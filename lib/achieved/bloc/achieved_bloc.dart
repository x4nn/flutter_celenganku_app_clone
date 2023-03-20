import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'achieved_event.dart';
part 'achieved_state.dart';

class AchievedBloc extends Bloc<AchievedEvent, AchievedState> {
  AchievedBloc() : super(AchievedInitial()) {
    on<AchievedEvent>((event, emit) {});
  }
}
