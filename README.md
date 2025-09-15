# SuperCollider MIDI & Music Analysis Tools

Tools per l'analisi musicale e la conversione di dati MIDI in SuperCollider, con funzioni di sonificazione di testi poetici.

## Descrizione

Strumenti per:
- Conversione numeri MIDI in nomi di note con ottave
- Generazione di pattern musicali

Esempio incluso: sonificazione di "L'Homme et la Mer" di Charles Baudelaire.

## Installazione

**Prerequisiti**: SuperCollider 3.11+

```bash
git clone https://github.com/karmagally/supercollider-midi-tools.git
```

Caricare in SuperCollider:
```supercollider
"path/to/main.scd".load;
```

## Utilizzo

### Conversione MIDI

```supercollider
// Conversione base
~midiArrayToNotes.value([60, 64, 67], [1, 2, 4]);
// Output: "C5 1", "E5 2", "G5 4"

// Scale cromatiche
~midiArrayToNotes.value((60..71), Array.fill(12, 3));
```

### Sintesi Audio

```supercollider
// 1. Definire SynthDef
SynthDef(\SphShell, { /* vedi main.scd */ }).add;

// 2. Creare pattern
~sheet1 = Pbind(
    \instrument, \SphShell,
    \baseFreq, Pseq((~arr.midicps.mirror), inf),
    \amp, Pwhite(-12, -6).dbamp,
    \dur, ~dur,
    \pan, Pwhite(-1.0, 1.0)
);

// 3. Eseguire
~sheet1.play;
```

## API

### `~midiArrayToNotes(midi_array, durate)`

Converte array MIDI in nomi note.

**Parametri:**
- `midi_array`: Array numeri MIDI (0-127)
- `durate`: Array durate corrispondenti

**Output:** Stampa note formattate

### SynthDef `\SphShell`

**Parametri:**
- `baseFreq`: Frequenza base (default: 5088)
- `pan`: Posizione stereo (-1.0 to 1.0)  
- `amp`: Ampiezza (0.0 to 1.0)

## Struttura

```
supercollider-midi-tools/
├── README.md
├── main.scd
├── .gitignore
└── LICENSE
```

## Esempio

Il progetto include sonificazione di "L'Homme et la Mer":
- Frequenze derivate da analisi testuale
- Pattern ritmici basati su metrica poetica
- Struttura palindroma con `.mirror`

## Licenza

MIT License - Copyright (c) 2025 Simone De Benedetto

## Crediti

- Algoritmo MIDI: [Coding Tech Room](https://codingtechroom.com/question/convert-midi-note-numbers-to-names-and-octaves)
- Testo: Charles Baudelaire

---

# SuperCollider MIDI & Music Analysis Tools

Tools for musical analysis and MIDI data conversion in SuperCollider, with poetic text sonification example.

## Description

Tools for:
- Converting MIDI numbers to note names with octaves
- Audio synthesis with custom SynthDefs
- Musical pattern generation

Included example: sonification of "L'Homme et la Mer" by Charles Baudelaire.

## Installation

**Requirements**: SuperCollider 3.11+

```bash
git clone https://github.com/username/supercollider-midi-tools.git
```

Load in SuperCollider:
```supercollider
"path/to/main.scd".load;
```

## Usage

### MIDI Conversion

```supercollider
// Basic conversion
~midiArrayToNotes.value([60, 64, 67], [1, 2, 4]);
// Output: "C5 1", "E5 2", "G5 4"

// Chromatic scales
~midiArrayToNotes.value((60..71), Array.fill(12, 0.25));
```

### Audio Synthesis

```supercollider
// 1. Define SynthDef
SynthDef(\SphShell, { /* see main.scd */ }).add;

// 2. Create pattern
~sheet1 = Pbind(
    \instrument, \SphShell,
    \baseFreq, Pseq((~arr.midicps.mirror), inf),
    \amp, Pwhite(-12, -6).dbamp,
    \dur, ~dur,
    \pan, Pwhite(-1.0, 1.0)
);

// 3. Execute
~sheet1.play;
```

## API

### `~midiArrayToNotes(midi_array, durate)`

Converts MIDI array to note names.

**Parameters:**
- `midi_array`: MIDI numbers array (0-127)
- `durate`: Corresponding durations array

**Output:** Formatted note printout

### SynthDef `\SphShell`

**Parameters:**
- `baseFreq`: Base frequency (default: 5088)
- `pan`: Stereo position (-1.0 to 1.0)
- `amp`: Amplitude (0.0 to 1.0)

## Structure

```
supercollider-midi-tools/
├── README.md
├── main.scd
├── .gitignore
└── LICENSE
```

## Example

Project includes "L'Homme et la Mer" sonification:
- Frequencies derived from textual analysis
- Rhythmic patterns based on poetic meter
- Palindromic structure with `.mirror`

## License

MIT License - Copyright (c) 2025 Simone De Benedetto

## Credits

- MIDI Algorithm: [Coding Tech Room](https://codingtechroom.com/question/convert-midi-note-numbers-to-names-and-octaves)
- Text: Charles Baudelaire
