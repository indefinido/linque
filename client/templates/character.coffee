Template.character.onCreated ->
  @subscribe 'user'
  # @subscribe 'movement'

Template.character.onRendered ->

  @autorun ->
    @user ||= Meteor.user()
    return unless @user
    node    = @firstNode()

    $(node).detach()
    
    @userDot = $ "linque-path > linque-dot:nth-last-child(#{@user.position})"

    @userDot.get(0).setAttribute 'free', true
    @userDot.append node
