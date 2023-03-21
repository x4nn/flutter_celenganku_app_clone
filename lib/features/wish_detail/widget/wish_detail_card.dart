import 'package:celenganku_app_clone/features/wish_detail/wish_detail.dart';
import 'package:celenganku_app_clone/shared/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishDetailCard extends StatelessWidget {
  const WishDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: BlocBuilder<WishBloc, WishState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
                child: Column(
                  children: [
                    _WishTargetInfo(wish: state.wish),
                    const Divider(height: 24),
                    _WishTimeInfo(wish: state.wish),
                    const Divider(height: 24),
                    _WishSavingInfo(wish: state.wish),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _WishTargetInfo extends StatelessWidget {
  const _WishTargetInfo({required this.wish});

  final Wish wish;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Rp. ${wish.savingTarget}", style: const TextStyle(fontSize: 28)),
              const SizedBox(height: 5),
              Text(
                "Rp. ${wish.savingNominal} Per${Wish.savingPlanTimeName(wish.savingPlan).toLowerCase()}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: 1.2,
              child: CircularProgressIndicator.adaptive(
                value: wish.getSavingPercentage() / 10,
                backgroundColor: theme.primaryColorLight,
              ),
            ),
            Text("${wish.getSavingPercentage().toStringAsFixed(0)}%", style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}

class _WishTimeInfo extends StatelessWidget {
  const _WishTimeInfo({required this.wish});

  final Wish wish;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Dibuat", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(wish.createdAt.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Tercapai", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              "${wish.getEstimatedRemainingTime()} ${Wish.savingPlanTimeName(wish.savingPlan)} Lagi",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class _WishSavingInfo extends StatelessWidget {
  const _WishSavingInfo({required this.wish});

  final Wish wish;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              const Text("Terkumpul", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(
                "Rp. ${wish.getTotalSaving()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50, width: 15, child: VerticalDivider()),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              const Text("Kurang", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(
                "Rp. ${wish.savingTarget - wish.getTotalSaving()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
