import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pbn_flutter/controllers/player_controller.dart';
import 'package:pbn_flutter/repositories/abstracts/iplayer_repository.dart';

class ScoreModal extends StatefulWidget {
  final String playerId;

  ScoreModal({required this.playerId, Key? key}) : super(key: key) {}

  @override
  _ScoreModalState createState() => _ScoreModalState();
}

class _ScoreModalState extends State<ScoreModal> {
  TextEditingController _scoreController = TextEditingController();

  @override
  void setState(VoidCallback fn) {
    _playerController = PlayerController(_playerRepository);
    super.setState(fn);
  }

  @override
  void dispose() {
    _scoreController.dispose();
    super.dispose();
  }

  final IPlayerRepository _playerRepository =
      GetIt.instance<IPlayerRepository>();

  late final PlayerController _playerController;

  void _sendScore() {
    // Get the score value from the text field
    final double newScore = double.parse(_scoreController.text);

    _playerRepository.addScore(widget.playerId, newScore);
    // Close the modal and pass the new score back to the player list
    Navigator.of(context).pop(newScore);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter New Score',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _scoreController,
              decoration: const InputDecoration(
                labelText: 'Score',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _sendScore,
                  child: const Text('Send'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
