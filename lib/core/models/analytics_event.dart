typedef Events = AnalyticsEvent;

class AnalyticsEvent {
  /// The name of this event
  final String name;

  /// A map of additional properties
  final Map<String, dynamic>? props;

  AnalyticsEvent(this.name, {this.props});

  AnalyticsEvent withProp(String propName, dynamic propValue) {
    final newProps = props ?? {};
    newProps[propName] = propValue;
    return AnalyticsEvent(name, props: newProps);
  }

  AnalyticsEvent withLocation(String location) =>
      withProp('Location', location);

  // -------- Auth/Login --------

  static AnalyticsEvent loginViewed = AnalyticsEvent('User Login Page Viewed');

  static AnalyticsEvent loggedIn = AnalyticsEvent('User Logged On');

  static AnalyticsEvent loggedOutManual =
      AnalyticsEvent('User Logged Off').withLocation('Manual');

  static AnalyticsEvent loggedOutSystem =
      AnalyticsEvent('User Logged Off').withLocation('System-triggered');

  AnalyticsEvent.loginStep(String step)
      : name = 'User Login Step',
        props = {'Step': step};

  AnalyticsEvent.loginFailed(String reason)
      : name = 'User Login Step Failed',
        props = {'Context': reason};

  // -------- Profile Menu --------

  static AnalyticsEvent knowledgeCenterLinkClicked =
      AnalyticsEvent('Knowledge Center Link Clicked');

  AnalyticsEvent.profileViewed(String profileId)
      : name = 'Profile Viewed',
        props = {'ProfileOwnerId': profileId};

  AnalyticsEvent.profileTabClicked(String itemClicked)
      : name = 'Profile Tab Clicked',
        props = {'ItemClicked': itemClicked};

  // -------- Notifications --------

  static AnalyticsEvent notificationSettingsViewed =
      AnalyticsEvent('Push Notifications Settings Viewed');

  AnalyticsEvent.notificationSettingUpdated(String itemClicked, bool isEnabled)
      : name = 'Push Notification Setting Updated',
        props = {'ItemClicked': itemClicked, 'Value': isEnabled};
}
