# SuperCollider MIDI & Music Analysis Tools

Un progetto SuperCollider per l'analisi e la conversione di dati musicali, con particolare focus sulla trasformazione di array MIDI in notazione musicale e sull'elaborazione di materiale melodico.

## Descrizione

Questo repository contiene strumenti SuperCollider per:
- Conversione di numeri MIDI in nomi di note con ottave
- Analisi di frequenze e durate musicali
- Generazione di pattern musicali basati su testo poetico
- Sintesi audio con strumenti personalizzati

## File Principali

### `main.scd`
File principale contenente:
- Funzione `~midiArrayToNotes`: convertitore MIDI -> nomi note
- Esempio pratico basato su "L'Homme et la Mer" 
- Pattern Pbind per sintesi audio

## Installazione

1. Assicurati di avere SuperCollider installato (versione 3.11+)
2. Clona questa repository:
   ```bash
   git clone https://github.com/TUO-USERNAME/supercollider-midi-tools.git
   ```
3. Apri SuperCollider e carica il file `main.scd`

## Utilizzo

### Conversione MIDI

```supercollider
// Esempio base
~midiArrayToNotes.value([60, 64, 67], [1, 2, 4]);
// Output: C5 1, E5 2, G5 4
```

### Analisi Musicale

Il progetto include un esempio pratico basato su analisi di frequenze estratte da materiale poetico-musicale, dimostrando come:
- Convertire frequenze in hertz
- Applicare durate metriche
- Generare pattern audio

## Funzioni Principali

### `~midiArrayToNotes(midi_array, durate)`

**Parametri:**
- `midi_array`: Array di numeri MIDI (default: [60, 64, 67])
- `durate`: Array di durate corrispondenti (default: [1, 2, 4])

**Restituisce:** Stampa formattata delle note con ottave e durate

### Pattern Audio

Il progetto include configurazioni Pbind per:
- Strumento `\SphShell`
- Modulazione di frequenza base
- Controllo dinamico dell'ampiezza
- Spazializzazione stereo

## Esempio Completo

```supercollider
// Carica la funzione
~midiArrayToNotes= { 
    arg midi_array = [60, 64, 67], durate=[1,2,4];
    var notes, result;
    notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];
    result = midi_array.collect({|midi_num,i|
        var note, octave, durations;
        note = notes[midi_num%12];
        octave = (midi_num/12)-1;
        durations = durate[i];
        note++octave++" "++durations;
    });
    result.printAll;
};

// Usa con i tuoi dati
~midiArrayToNotes.value([72, 74, 76], [0.5, 1, 1.5]);
```

## Crediti

- Algoritmo di conversione MIDI basato su: [Coding Tech Room](https://codingtechroom.com/question/convert-midi-note-numbers-to-names-and-octaves)
- Materiale musicale ispurato a "L'Homme et la Mer"

## Struttura del Progetto

```
supercollider-midi-tools/
├── README.md
├── main.scd                 # File principale
├── docs/
│   └── documentation.md     # Documentazione dettagliata
└── examples/
    └── basic_usage.scd      # Esempi d'uso
```

## Contribuire

1. Fai un fork del progetto
2. Crea un branch per la tua feature (`git checkout -b feature/AmazingFeature`)
3. Commit le tue modifiche (`git commit -m 'Add some AmazingFeature'`)
4. Push al branch (`git push origin feature/AmazingFeature`)
5. Apri una Pull Request

## Licenza

Questo progetto è distribuito sotto licenza MIT. Vedi il file `LICENSE` per i dettagli.

## Contatti

Per domande o suggerimenti, apri una issue su GitHub.

---

**Note:** Assicurati di avere configurato correttamente gli strumenti SuperCollider necessari prima dell'utilizzo.
