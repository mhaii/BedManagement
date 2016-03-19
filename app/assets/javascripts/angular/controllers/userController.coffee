userController = (sessionService, userService)->
  @session      = sessionService
  @user         = {}

  hashPassword  = =>
    @user.password = sha1 @user.rawPassword if @user.rawPassword
    delete @user.rawPassword

  @login        = (e)=>
    e.preventDefault()
    hashPassword()
    @user.remember_me = @user.remember and 1 or 0
    userService.currentUser.save(@user).$promise.then (-> location.reload()), (response)=>
      console.log response
      @error = response.data.error
      delete @user.password

  @createUser   = =>
    hashPassword()
    userService.user.save(@user).$promise.then =>
      @user     = {}
      @message  = 'USER_CREATED'
    , (response)=>
      @user.password = null
      @message  =  response.data.username and 'USERNAME_ALREADY_EXISTED' or
                   response.data.password and 'PASSWORD_MUST_NOT_BE_BLANK'

  @selectRole = (role)=>  @user.role    = role
  @selectWard = (ward)=>  @user.ward_id = ward.id

  return

userController.$inject = ['sessionService', 'userService']

angular.module('app').controller('userController', userController)