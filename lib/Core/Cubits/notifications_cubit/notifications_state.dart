part of 'notifications_cubit.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class ReplayLoading extends NotificationsState {}

class ReplaySucceeded extends NotificationsState {}

class ReplayFailed extends NotificationsState {
  final String error;

  ReplayFailed(this.error);
}

class NotificationsEmpty extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationData> nots;

  NotificationsLoaded(this.nots);
}

class NotificationsFailed extends NotificationsState {
  final String error;

  NotificationsFailed(this.error);
}
