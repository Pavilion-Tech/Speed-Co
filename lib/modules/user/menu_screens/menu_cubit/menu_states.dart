abstract class MenuStates{}

class InitState extends MenuStates{}
class ImageWrong extends MenuStates{}
class JustEmitState extends MenuStates{}
class GetCurrentLocationState extends MenuStates{}
class GetCurrentLocationLoadingState extends MenuStates{}

class GetUserSuccessState extends MenuStates{}
class GetUserWrongState extends MenuStates{}
class GetUserErrorState extends MenuStates{}

class UpdateUserLoadingState extends MenuStates{}
class UpdateUserSuccessState extends MenuStates{}
class UpdateUserWrongState extends MenuStates{}
class UpdateUserErrorState extends MenuStates{}

class GetOrderLoadingState extends MenuStates{}
class GetOrderSuccessState extends MenuStates{}
class GetOrderWrongState extends MenuStates{}
class GetOrderErrorState extends MenuStates{}

class ContactLoadingState extends MenuStates{}
class ContactSuccessState extends MenuStates{}
class ContactWrongState extends MenuStates{}
class ContactErrorState extends MenuStates{}

class NotificationLoadingState extends MenuStates{}
class NotificationSuccessState extends MenuStates{}
class NotificationWrongState extends MenuStates{}
class NotificationErrorState extends MenuStates{}
