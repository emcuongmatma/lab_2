import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_2/common/app_string.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/data/model/profile.dart';
import 'package:lab_2/domain/usecase/auth_usecase.dart';
import 'package:lab_2/generated/assets.dart';
import 'package:lab_2/presentation/widgets/text_span_with_action.dart';
import 'package:lab_2/injection.dart' as di;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            onPressed: () {
              if (context.canPop()) context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorLight.gray400,
              weight: 40,
            ),
          ),
        ),
        title: Text(
          AppString.studyProfile,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: ColorLight.gray700),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings_outlined,
                color: ColorLight.neutralEel,
                weight: 40,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: di.locator<AuthUseCase>().fetchProfile(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            List<Profile> profiles = snapshot.data!.match(
              (failure) => <Profile>[],
              (result) => result,
            );
            debugPrint(profiles.toString());
            snapshot.data?.match((failure) {}, (result) => profiles = result);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const Spacer(),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.8,
                        ),
                    itemCount: profiles.length % 2 == 0
                        ? profiles.length
                        : profiles.length + 1,
                    itemBuilder: (context, index) {
                      if (index < profiles.length) {
                        return ProfileItem(profile: profiles[index]);
                      } else {
                        return AddProfileItem(onClick: () {});
                      }
                    },
                  ),
                  if (profiles.length % 2 == 0)
                    Center(
                      child: SizedBox(
                        width: (MediaQuery.of(context).size.width - 50 - 8) / 2,
                        child: AddProfileItem(onClick: () {}),
                      ),
                    ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: TextSpanWithAction(
                      text1: "",
                      text2: AppString.enterActiveCode,
                      onAction: () {},
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final Profile profile;

  const ProfileItem({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Card(
            color: Color(int.parse(profile.backgroundColor!)),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(36)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                ),
                child: CachedNetworkImage(
                  imageUrl: profile.avatar ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          profile.name ?? "",
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: ColorLight.gray700),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class AddProfileItem extends StatelessWidget {
  final VoidCallback onClick;

  const AddProfileItem({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Card(
              color: ColorLight.gray100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(36)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: SvgPicture.asset(Assets.iconsIcAdd),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppString.add,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: ColorLight.gray300),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
