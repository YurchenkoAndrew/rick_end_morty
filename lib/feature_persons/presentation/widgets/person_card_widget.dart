import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rick_end_morty/common/app_colors.dart';
import 'package:rick_end_morty/feature_persons/domain/entities/person_entity.dart';
import 'package:rick_end_morty/feature_persons/presentation/widgets/person_cache_image_widget.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;

  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cellBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            child: PersonCacheImage(
              imageUrl: person.image,
              width: 166,
              height: 166,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Text(
                  person.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: person.status == 'Alive'
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        '${person.status} - ${person.species}',
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Last know location: ',
                  style: TextStyle(color: AppColors.greyBackground),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  person.location.name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Origin',
                  style: TextStyle(color: AppColors.greyBackground),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  person.origin.name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
