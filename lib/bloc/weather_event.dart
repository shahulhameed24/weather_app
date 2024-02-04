part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

/// Extending Weather event
class FetchWeather extends WeatherEvent {
  final Position position;

  const FetchWeather(this.position);

  @override
  // TODO: implement props
  List<Object?> get props => [position];
}
