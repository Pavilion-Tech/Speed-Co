abstract class ProviderStates{}

class InitState extends ProviderStates{}
class EmitState extends ProviderStates{}
class GetCurrentLocationLoadingState extends ProviderStates{}
class GetCurrentLocationState extends ProviderStates{}

class GetProviderSuccessState extends ProviderStates{}
class GetProviderWrongState extends ProviderStates{}
class GetProviderErrorState extends ProviderStates{}


class GetRequestLoadingState extends ProviderStates{}
class GetRequestSuccessState extends ProviderStates{}
class GetRequestWrongState extends ProviderStates{}
class GetRequestErrorState extends ProviderStates{}