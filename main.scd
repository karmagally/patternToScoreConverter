/*
=============================================================================
SUPERCOLLIDER MIDI & MUSIC ANALYSIS TOOLS
=============================================================================

Questo file contiene strumenti per l'analisi musicale e la conversione
di dati MIDI in SuperCollider.

Autore: [Simone De Benedetto]
Versione: 1.0
Data: [05/09/2025]

=============================================================================
*/

// CREDITI E RIFERIMENTI
// Algoritmo di conversione MIDI -> Note basato su:
// "https://codingtechroom.com/question/convert-midi-note-numbers-to-names-and-octaves"

/*
=============================================================================
FUNZIONE PRINCIPALE: CONVERSIONE MIDI -> NOMI NOTE
=============================================================================
*/

(
/**
 * Converte un array di numeri MIDI in nomi di note con ottave e durate
 *
 * @param midi_array: Array di numeri MIDI (0-127)
 * @param durate: Array di durate corrispondenti ad ogni nota
 * @return: Stampa formattata delle note risultanti
 *
 * Esempio: ~midiArrayToNotes.value([60, 64, 67], [1, 2, 4])
 * Output: "C5 1", "E5 2", "G5 4"
 */
~midiArrayToNotes = {
    arg midi_array = [60, 64, 67],        // Array MIDI di default (Do maggiore)
        durate = [1, 2, 4];               // Durate di default

    var notes, result;

    // Array delle 12 note cromatiche (partendo da C)
    notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];

    // Elabora ogni numero MIDI dell'array
    result = midi_array.collect({|midi_num, i|
        var note, octave, durations;

        // Calcola la nota usando il modulo 12
        note = notes[midi_num % 12];

        // Calcola l'ottava (MIDI 60 = C4, quindi sottraiamo 1)
        octave = (midi_num / 12) - 1;

        // Preleva la durata corrispondente
        durations = durate[i];

        // Combina nota, ottava e durata in una stringa
        note ++ octave ++ " " ++ durations;
    });

    // Stampa tutti i risultati
    result.printAll;
};
);

/*
=============================================================================
ESEMPIO PRATICO: SONIFICAZIONE DA "L'HOMME ET LA MER" Charles Baudelaire
=============================================================================
*/

// DATI MUSICALI ESTRATTI
// Definizione Note Midi derivate dal testo poetico
(
~arr = [
    113.41737891842, 120.91126929732, 120.59649079844, 120.59649079844, 119.27681669414,
    99.378278901116, 120.43692892708, 119.94922511311, 118.7547970305,  121.37295907109,
    119.27681669414, 104.89145832476, 99.378278901116, 121.67405084265, 120.91126929732,
    121.82265553612, 120.11332435587, 120.91126929732, 121.82265553612, 121.37295907109
];

// PATTERN RITMICO
// Durate che seguono la metrica del testo poetico
// .mirror crea una versione palindroma del pattern
// Pseq(..., 3) ripete il pattern 3 volte
~dur = Pseq([1, 0.5, 2, 2, 0.5, 1.5, 0.5, 0.5, 1.5, 0.5, 2, 0.5, 1, 1, 1, 1, 1].mirror, 3);

// Converte il pattern in array per l'uso con la funzione di conversione
~durArg = ~dur.asStream.nextN(65);
);
/*
=============================================================================
SINTESI AUDIO: PATTERN PBIND
=============================================================================
*/

// CONFIGURAZIONE PATTERN AUDIO

/**
 * Pattern Pbind per la sintesi audio del materiale melodico
 *
 * Utilizza:
 * - Ampiezza dinamica randomizzata
 * - Spazializzazione stereo casuale
 */

//DEFINIZIONE SYNTHDEF

(
 SynthDef(\SphShell,
	{arg n,baseFreq= 5088,pan=0.0,amp=1;
		var freqRatios, sig, filter,stereo;

		freqRatios =    [1 ,1.184 , 1.253 , 1.312];

		sig = Impulse.ar(0.001);
		filter = Formlet.ar(sig,baseFreq * freqRatios,[1,1,1,1],[0.25,0.25,0.25,0.25],0.5);
		stereo = Pan2.ar(Mix(filter)*amp, pan);
		Out.ar(0, stereo);
	}
).add;

(
 ~sheet1 = Pbind(
	\instrument, \SphShell,                              // Strumento di sintesi
	
	// CONTROLLO FREQUENZA
	\baseFreq, Pseq((~arr.midicps.mirror), inf) /       // Pattern di frequenze base
	Prand([2, 4, 8, 16, 32], inf),           // Divisori di ottava casuali
	
	// CONTROLLO DINAMICO
	\amp, Pwhite(-12, -6).dbamp,                        // Ampiezza: da -48dB a -6dB
	
	// CONTROLLO TEMPORALE
	\dur, ~dur,                                      // Durate
	
	// CONTROLLO SPAZIALE
	\pan, Pwhite(-1.0, 1.0)                            // Posizione stereo casuale
));
)

// esegui il pattern
~sheet1.play;

/*
=============================================================================
FUNZIONI UTILI AGGIUNTIVE
=============================================================================
*/

/*
=============================================================================
ESECUZIONE ESEMPIO
=============================================================================
*/

// ESEGUI LA CONVERSIONE MIDI
// Applica la funzione di conversione ai dati dell'esempio
~midiArrayToNotes.value(~arr, ~durArg);

/*
=============================================================================
NOTE D'USO:
=============================================================================

1. Assicurati che lo strumento \SphShell sia definito prima dell'esecuzione
2. Definisci la variabile ~arr per il pattern audio
3. Usa .play sul Pbind per avviare la riproduzione:
   ~sheet1.play;


ESEMPI DI UTILIZZO RAPIDO:

// Conversione semplice
~midiArrayToNotes.value([60, 62, 64], [1, 1, 2]);

// Con accordi
~midiArrayToNotes.value([60, 64, 67, 72], [4, 4, 4, 4]);

// Scale cromatiche
~midiArrayToNotes.value((60..71), Array.fill(12, 0.25));

=============================================================================
*/
