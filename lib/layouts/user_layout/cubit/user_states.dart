abstract class UserStates {}

class InitState extends UserStates {}

class EmitState extends UserStates {}

class ImageWrong extends UserStates {}

class ImagesPickedState extends UserStates {}

class ChangeIndexState extends UserStates {}

class GetCurrentLocationLoadingState extends UserStates {}

class GetCurrentLocationState extends UserStates {}

class GetHomeLoadingState extends UserStates {}
class GetHomeSuccessState extends UserStates {}
class GetHomeWrongState extends UserStates {}
class GetHomeErrorState extends UserStates {}

class PlaceOrderLoadingState extends UserStates {}
class PlaceOrderSuccessState extends UserStates {}
class PlaceOrderWrongState extends UserStates {}
class PlaceOrderErrorState extends UserStates {}

class RateLoadingState extends UserStates {}
class RateSuccessState extends UserStates {}
class RateWrongState extends UserStates {}
class RateErrorState extends UserStates {}

class SearchLoadingState extends UserStates {}
class SearchSuccessState extends UserStates {}
class SearchWrongState extends UserStates {}
class SearchErrorState extends UserStates {}



class DateSuccessState extends UserStates {}
class DateWrongState extends UserStates {}
class DateErrorState extends UserStates {}