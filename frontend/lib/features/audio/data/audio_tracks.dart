class AudioTrack {
  final String name;
  final String icon;
  final String url;

  const AudioTrack({required this.name, required this.icon, required this.url});
}

// Free ambient sound URLs (CC0 licensed from freesound/pixabay)
const audioTracks = [
  AudioTrack(
    name: 'Rain',
    icon: '🌧️',
    url: 'https://cdn.pixabay.com/audio/2022/05/28/audio_69a61c8fa9.mp3',
  ),
  AudioTrack(
    name: 'Brown Noise',
    icon: '🟤',
    url: 'https://cdn.pixabay.com/audio/2024/04/04/audio_8a796c4e59.mp3',
  ),
  AudioTrack(
    name: 'Forest',
    icon: '🌲',
    url: 'https://cdn.pixabay.com/audio/2022/03/09/audio_c615b2a694.mp3',
  ),
  AudioTrack(
    name: 'Lo-fi',
    icon: '🎵',
    url: 'https://cdn.pixabay.com/audio/2022/05/27/audio_1808fbf07a.mp3',
  ),
  AudioTrack(
    name: 'Cafe',
    icon: '☕',
    url: 'https://cdn.pixabay.com/audio/2021/08/09/audio_93babb7ac2.mp3',
  ),
  AudioTrack(
    name: 'White Noise',
    icon: '📻',
    url: 'https://cdn.pixabay.com/audio/2024/11/04/audio_ecf1e77e71.mp3',
  ),
];
