import "package:flutter/material.dart";

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildCustomSnackBar({
  required BuildContext context,
  required String message,
  error = false,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: error
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.all(5),
      content: SizedBox(
        //  height: 50,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Icon(
                error ? Icons.warning_outlined : Icons.check_outlined,
                color: Colors.white,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  message,
                  maxLines: 3,
                  overflow: TextOverflow.visible,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
