import { useRef } from 'react'
import { Howl } from 'howler'

export default function AudioPlayer() {
    const audioPlayer = useRef(null)

    const playSound = (filename) => {
        if (!filename) {
        if (audioPlayer.current && audioPlayer.current.playing()) {
            audioPlayer.current.stop()
        }
        return
        }

        if (audioPlayer.current && audioPlayer.current.playing()) {
        audioPlayer.current.stop()
        }

        const audioPath = `./sounds/${filename}`

        audioPlayer.current = new Howl({
        src: [audioPath],
        volume: 0.7
        })

        audioPlayer.current.play()
    }

    return playSound
}