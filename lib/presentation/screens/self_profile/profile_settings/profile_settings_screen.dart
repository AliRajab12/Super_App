import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/widgets/adaptive_alert_dialog.dart';
import 'package:somi/core/widgets/degreed_avatar.dart';
import 'package:somi/core/widgets/degreed_snack_bar.dart';
import 'package:somi/core/widgets/linear_loading_indicator.dart';
import 'package:somi/core/widgets/secondary_button.dart';
import 'package:somi/core/widgets/text_button.dart';
import 'package:somi/presentation/screens/self_profile/profile_settings/profile_settings_cubit.dart';
import 'package:somi/presentation/screens/self_profile/profile_settings/profile_settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final ProfileSettingsCubit cubit = locator<ProfileSettingsCubit>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode bioFocus = FocusNode();

  @override
  void initState() {
    firstNameController.text = cubit.state.firstName;
    lastNameController.text = cubit.state.lastName;
    bioController.text = cubit.state.bio;
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingsCubit, ProfileSettingsState>(
      bloc: cubit,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => displayUnsavedConfirmation(context, state),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: buildListeners(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(AppLocalizations.of(context)!.profileSettings),
                  actions: [
                    if (state.hasProfileChanges)
                      TxtButton.large(
                        text: AppLocalizations.of(context)!.save,
                        textColor: AppColors.primary,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          cubit.saveProfile();
                        },
                      ),
                  ],
                ),
                body: buildBody(context, state),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileSettingsCubit, ProfileSettingsState>(
          bloc: cubit,
          listenWhen: (previous, current) =>
              previous.profileSaveError != current.profileSaveError,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(DegreedSnackBar.error(
                message: AppLocalizations.of(context)!.saveError));
          },
        ),
        BlocListener<ProfileSettingsCubit, ProfileSettingsState>(
          bloc: cubit,
          listenWhen: (previous, current) =>
              previous.pictureSaveError != current.pictureSaveError,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(DegreedSnackBar.error(
                message: AppLocalizations.of(context)!.saveError));
          },
        ),
        BlocListener<ProfileSettingsCubit, ProfileSettingsState>(
          bloc: cubit,
          listenWhen: (previous, current) =>
              previous.resetOnboardingError != current.resetOnboardingError,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(DegreedSnackBar.error(
                message:
                    AppLocalizations.of(context)!.checkInternetConnection));
          },
        ),
      ],
      child: child,
    );
  }

  Widget buildBody(BuildContext context, ProfileSettingsState state) {
    bool isSaving = state.isSavingPicture || state.isSavingProfile;
    final orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return buildVertical(context, state, isSaving);
    } else {
      return buildHorizontal(context, state, isSaving);
    }
  }

  Widget buildVertical(
      BuildContext context, ProfileSettingsState state, bool isSaving) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        buildPhotoSection(context, state, isSaving),
        const SizedBox(height: 12),
        buildInfoSection(context, state, isSaving),
      ],
    );
  }

  Widget buildHorizontal(
      BuildContext context, ProfileSettingsState state, bool isSaving) {
    return SafeArea(
      bottom: false,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Center(child: buildPhotoSection(context, state, isSaving)),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            flex: 5,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 24, right: 16, bottom: 24),
              child: buildInfoSection(context, state, isSaving),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPhotoSection(
      BuildContext context, ProfileSettingsState state, bool isSaving) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DegreedAvatar(
          name: state.firstName,
          imageUrl: state.picturePath,
          size: 128,
          activeLearner: false,
          imageData: state.editedPictureData,
        ),
        // DegreedAvatar.self(size: 128, imageData: state.editedPictureData),
        const SizedBox(height: 8),
        Visibility(
          visible: state.canEditPicture,
          child: Center(
            child: SecondaryButton(
              key: const Key('change-photo'),
              onPressed: isSaving ? null : () => cubit.updatePicture(),
              text: AppLocalizations.of(context)!.changeProfilePhoto,
              icon: Icons.add_a_photo,
            ),
          ),
        ),
        Center(
          child: ExcludeSemantics(child: LinearLoadingIndicator(isSaving)),
        ),
      ],
    );
  }

  Widget buildInfoSection(
      BuildContext context, ProfileSettingsState state, bool isSaving) {
    return Column(
      children: [
        Card(
          child: Column(
            children: [
              Card(
                child: buildInput(
                  const Key('first-name'),
                  AppLocalizations.of(context)!.firstName,
                  firstNameFocus,
                  firstNameController,
                  cubit.setEditedFirstName,
                ),
              ),
              const Divider(height: 1, color: SomiColors.ebonySolid18),
              Card(
                child: buildInput(
                  const Key('last-name'),
                  AppLocalizations.of(context)!.lastName,
                  lastNameFocus,
                  lastNameController,
                  cubit.setEditedLastName,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: buildInput(
            const Key('bio'),
            AppLocalizations.of(context)!.bio,
            bioFocus,
            bioController,
            cubit.setEditedBio,
            maxLines: null,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            onTap: () => displayOnboardingResetConfirmation(context),
            title: Text(AppLocalizations.of(context)!.resetOnboarding),
            trailing: const Icon(Icons.navigate_next, size: 14),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget buildInput(
    Key? key,
    String title,
    FocusNode focusNode,
    TextEditingController controller,
    ValueChanged<String>? onChanged, {
    int? maxLines = 1,
  }) {
    final enabled = cubit.state.canEditProfile && !cubit.state.isSavingProfile;
    return ListTile(
      minVerticalPadding: 12,
      onTap: enabled ? () => focusNode.requestFocus() : null,
      title: Text(title),
      subtitle: TextField(
        key: key,
        enabled: enabled,
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodyMedium,
        maxLines: maxLines,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          hintText: '',
          border: InputBorder.none,
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(vertical: 4),
        ),
      ),
    );
  }

  void displayOnboardingResetConfirmation(BuildContext context) async {
    bool shouldReset = await showDegreedAdaptiveDialog(
      context,
      (context) => AdaptiveAlertDialog(
        title: Text(AppLocalizations.of(context)!.areYouSure),
        content: Text(
            AppLocalizations.of(context)!.resetOnboardingConfirmationMessage),
        actions: [
          DialogAction(
              label: AppLocalizations.of(context)!.cancel, result: false),
          DialogAction(
              label: AppLocalizations.of(context)!.yesImSure,
              result: true,
              isDefaultAction: true),
        ],
      ),
    );
    if (shouldReset) cubit.resetOnboarding();
  }

  Future<bool> displayUnsavedConfirmation(
      BuildContext context, ProfileSettingsState state) async {
    if (!state.hasProfileChanges) return true;
    return await showDegreedAdaptiveDialog(
      context,
      (context) => AdaptiveAlertDialog(
        title: Text(AppLocalizations.of(context)!.unsavedProfileDialogTitle),
        content:
            Text(AppLocalizations.of(context)!.unsavedProfileDialogMessage),
        actions: [
          DialogAction(
              label: AppLocalizations.of(context)!.cancel, result: false),
          DialogAction(
              label: AppLocalizations.of(context)!.discard,
              result: true,
              isDefaultAction: true),
        ],
      ),
    );
  }
}
