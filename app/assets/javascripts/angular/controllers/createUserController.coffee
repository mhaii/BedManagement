createUserController = (sessionService, userService)->
  @session    = sessionService

  @createUser = =>
    userService.user.save(@user).$promise.then =>
      @user = {}
      @message = 'USER_CREATED'
    , (response)=>
      console.log response
      @message =  response.data.username and 'USERNAME_ALREADY_EXISTED' or
                  response.data.password and 'PASSWORD_MUST_NOT_BE_BLANK'

  @selectRole = (role)=>  @user.role = role
  @selectWard = (ward)=>  @user.ward_id = ward.id

  return

createUserController.$inject = ['sessionService', 'userService']

angular.module('app').controller('createUserController', createUserController)