"_- Lo-Fi ~ [chaotic_algorithms] by TRIBΞHOLZ -_'
================================================.
     .-.   .-.     .--.                         |
    | OO| | OO|   / _.-' .-.   .-.  .-.   .''.  |
================================================"
use_bpm 100

bass_amp = 0.25
bell_amp = 0.5

s = "C:/Users/rober/Desktop/TRIBΞHOLZ/!SonicPi/Tracks/Lo-Fi/samples"


live_loop :click do
  sleep 1
end

live_loop :birbs, sync: :click do
  stop
  sample s, 2, amp: 0.3, beat_stretch: 24, rpitch: -12
  sleep 24
end

live_loop :frog, sync: :click do
  stop
  with_fx :slicer, phase: 1 do
    sample s, 3, amp: 1.2, beat_stretch: 1,
      rpitch: ring(-10, -14).tick
    sleep 4
  end
end

live_loop :slicebell, sync: :click do
  stop
  with_fx :slicer, phase: 0.5 do
    use_synth :pretty_bell
    play chord(:c3, :m11, invert: 0), amp: bell_amp, sustain: 2, release: 0
    sleep 2
    play chord(:f3, :m9, invert: 1), amp: bell_amp, sustain: 2, release: 0
    sleep 2
    play chord(:c3, :m11, invert: 1), amp: bell_amp, sustain: 2, release: 0
    sleep 2
    play chord(:g3, :m9, invert: 1), amp: bell_amp, sustain: 2, release: 0
    sleep 2
  end
end

live_loop :bass, sync: :slicebell do
  stop
  use_synth :bass_foundation
  play :c2, amp: bass_amp, sustain: 2, release: 0
  play :c3, amp: bass_amp, sustain: 2, release: 0
  
  sleep 2
  play :f1, amp: bass_amp, sustain: 2, release: 0
  play :f2, amp: bass_amp, sustain: 2, release: 0
  
  sleep 2
  play :eb2, amp: bass_amp, sustain: 2, release: 0
  play :eb3, amp: bass_amp, sustain: 2, release: 0
  
  sleep 2
  play :g1, amp: bass_amp, sustain: 1, release: 0
  play :g2, amp: bass_amp, sustain: 1, release: 0
  
  sleep 1
  play :eb2, amp: bass_amp, sustain: 1, release: 0
  play :eb3, amp: bass_amp, sustain: 1, release: 0
  
  sleep 1
end


live_loop :drumkit, sync: :slicebell do
  #stop
  bass_drum   = [[1, 0, 0, 0, 0, 0, 0, 1],[1, 0, 0, 0, 0, 0, 0, 0],[1, 0, 0, 0, 0, 0, 0, 1],[1, 0, 1, 0, 0, 0, 0, 0]].flatten
  snare_drum  = [[0, 0, 0, 0, 1, 0, 0, 0],[0, 0, 0, 0, 1, 0, 1, 1],[0, 0, 0, 0, 1, 0, 0, 0],[0, 0, 0, 0, 1, 0, 0, 1]].flatten
  highhat     = [[0, 1, 1, 1, 0, 0, 0, 0],[0, 0, 0, 0, 0, 0, 0, 0],[0, 0, 0, 0, 0, 0, 0, 0],[0, 0, 0, 0, 0, 0, 0, 0]].flatten
  32.times do |i|
    if bass_drum[i] == 1
      sample s, 0, amp: 1, rpitch: 2
    end
    if snare_drum[i] == 1
      sample s, 1, amp: 0.5
    end
    if highhat[i] == 1
      sample :drum_cymbal_closed, amp: 0.5
    end
    sleep 0.25
  end
end

live_loop :piano, sync: :slicebell do
  #stop
  #with_fx :slicer, feedback: 0.5 do
  with_fx :reverb, room: 0.75, mix: 0.25 do
    melody = scale(:c4, :aeolian).shuffle #:aeolian, :yegah
    use_synth :piano
    play melody.tick, amp: 0.2, release: 0.3, pitch: 12, res: 0.8
    sleep 0.5
    #end
  end
end

live_loop :bass2 , sync: :slicebell do
  stop
  synth_co = range(60, 100).mirror
  with_fx :reverb, room: 0.1 do
    use_random_seed ring(11).tick
    8.times do
      with_synth :fm do
        n = (ring :b1, :c2, :d1).choose
        play n,
          amp: 0.5,
          release: rrand(1.0, 0.8),
          res: 0.5,
          wave: 1,
          pitch: 8,
          cutoff: 90
        sleep 0.5
      end # 0.5 2
    end
  end
end