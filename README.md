# exhale
my mirror of https://gitlab.com/ecodis/exhale/
xe aac encoder 

exhale, which is an acronym for "Ecodis eXtended High-efficiency And
Low-complexity Encoder", is a lightweight library and application to
encode uncompressed WAVE-format audio files into MPEG-4-format files
complying with the ISO/IEC 23003-3 (MPEG-D) Unified Speech and Audio
Coding (USAC, also known as Extended High-Efficiency AAC) standard.
In addition, exhale writes program peak-level and loudness data into
the generated MPEG-4 files according to the ISO/IEC 23003-4, Dynamic
Range Control (DRC) specification for use by decoders providing DRC.
exhale currently makes use of all frequency-domain (FD) coding tools
in the scalefactor based MDCT processing path. Its objective is high
quality mono, stereo, and multichannel coding at medium and high bit
rates, so the lower-rate USAC coding tools (ACELP, TCX, Enhanced SBR
and MPEG Surround with Unified Stereo coding) won't be integrated.
Important: Due to the missing lower-rate coding tools, the audio
quality at the lowest of exhale's bit-rate modes (18 kbit/s mono, 36
kbit/s stereo) doesn't reflect the full capabilities of the Extended
HE-AAC standard. Therefore, use the lowest bit-rate modes only when
required. Also, please don't attempt to modify exhale's source code
or to configure the command-line encoder to produce lower bit-rates.
Use only existing presets and input sampling rates of 32...48 kHz.


Copyright
(c) 2025 Christian R. Helmrich, project ecodis. All rights reserved.

License
exhale is being made available under an open-source license which is
based on the 3-clause BSD license but modified to address particular
aspects dictated by the nature and the output of this application.
The license text and release notes for the current version 1.2.1 can
be found in the include subdirectory of the exhale distribution.

Compilation
This section describes how to compile the exhale source code into an
executable application under Linux and Microsoft Windows. The binary
application files will show up in a newly created bin subdirectory
of the exhale distribution directory and/or a subdirectory thereof.
Note that, for advanced use cases, cmake files are provided as well.
See !2 (merged) for details.

Linux and MacOS (GNU Compiler Collection, gcc):
In a terminal, change to the exhale distribution directory and enter
make release
to build a release-mode executable with the default (usually 64-bit)
configuration. A 32-bit debug-mode executable can be built by typing
make BUILD32=1 debug

Microsoft Windows (Visual Studio 2012 and later):
Doubleclick the exhale_vs2012.sln file to open the project in Visual
Studio. Once it's loaded, rightclick on exhaleApp in the "Solution
Explorer" window on the right-hand side, then select Set as StartUp Project. Now simply press F7 to build the solution in debug mode.
To change the debugging command, rightclick again on exhaleApp and
select Properties. In the newly opened window click on Debugging
under "Configuration Properties" on the left-hand side. Then you can
edit the "Command Arguments" entry on the right-hand side as needed.
For fastest encoding speed, please select Release and x64 before
building the solution. This will create a release-mode 64-bit binary.
If you would like to build a dynamically linked library (DLL) of the
exhale source instead of an application binary, select Release DLL
instead of Release, rightclick on exhaleLib, and select Build.

Usage
This section describes how to run the exhale application either from
the command-line or using a third-party software providing WAVE data
to exhale's standard input pipe (stdin), such as foobar2000. See the
Wiki at https://gitlab.com/ecodis/exhale/-/wikis/home for more info.

Standalone (command-line):
In a terminal, change to exhale's bin subdirectory and then enter
./exhale (on Linux and MacOS) or exhale.exe (on Windows)
to print out usage information. As an example, the following command
exhale.exe 5 C:\Music\Input.wav C:\Music\Output.m4a
converts file Input.wav to file Output.m4a at roughly 128 kbit/s (if
the input signal is 2-channel stereo) and in Extended HE-AAC format.
There is also an expert mode providing two additional arguments:
exhale.exe b s 42 C:\Music\Input.wav C:\Music\Output.m4a
e.g. encodes Input.wav to Output.m4a at roughly 48 kbit/s stereo and
with SBR enabled, seamless operation (s forces media time 0 in the
edit list), and an independent frame interval of 42 (range 10...99).

Third-party stdin (foobar2000):
After downloading from www.foobar2000.org and starting the software,
load the desired input audio files into the playlist. Mark all files
to be converted, rightclick on one of them, and select Convert ->
.... In the newly opened window click on Output format. Once the
window content changed, double-click on entry AAC (exhale) and set
up the conversion. If that entry does not exist, click on Add New,
select Custom under "Encoder" and enter the following information:


Encoder file: exhale.exe (including path to the executable)

Extension: m4a

Parameters: # %d (where # is the bit-rate mode, i.e., 0...9 when
SBR is disabled, or a...g when SBR is enabled)

Format is: lossy

Highest BPS mode supported: 24 (or 32, doesn't matter much)

Encoder name: Extended HE-AAC (exhale)

Bitrate (kbps): (depends on bit-rate mode, see Usage above)

Settings: CVBR mode # (where # equals that in Parameters)

Then click on OK and on Back and, in the first "Converter Setup"
window, on Other and ensure the "Transfer..." box for the class of
input metadata that you wish to copy to the output files is checked.
Now set the destination settings as desired and click on Convert.

Development
If you are interested in contributing to exhale, please email one of
the developers. Merge requests with fixes and/or speedups are highly
appreciated.

v1.2.1.2
exhaleApp: avoid out-of-bounds AU writeouts, fix 5.1 WAV/MPEG channel mapping
exhaleLib: relax max. quantized spectral magnitude restriction 1, fix MSE test code
exhaleLib: clean quantizer + entropy coder, increase max. IPF AU size to 12 kbit/ch
exhaleLib: fix more high-rate efficiency issues, fix mode-f stereo coding (issue 33)


v1.2.1
exhaleApp: always determine MPEG-4 instantaneous bit-rate across 2048 samples
exhaleLib: added code for MSE optimized encoding (for tests, disabled by default)
exhaleLib: code cleanup in quantization.*, increase max. IPF AU size to 10 kbit/ch
exhaleLib: fix two rare high-rate quality issues (only affects CVBR modes above 5)


v1.2.0
C API correction, some code sanitizing (issue #24, merge requests !8–!11, J. Regan)
exhaleLib: code cleanup, very minor quality improvements in CVBR modes f and 5
exhaleLib: 5% speedup of all modes, better target rate matching in CVBR mode g
exhaleLib: work around MinGW compilation hickup (issue #26; thanks, C. Degawa!)


v1.1.9
exhaleApp: write encoder name and version as «udta» tool string into MP4 header
exhaleApp: optimize leading and trailing PCM read for gapless playback (issue #21)


v1.1.8
some final code cleanup, small code corrections and editorial changes for this year
exhaleLib: minor stereo quality tuning at lower rates, optional CBR mode via macro


v1.1.7
minor tuning at low SBR rates, enabled SBR coding at 22050 Hz input sample rate
exhaleApp: added expert modes for loudness leveling, custom Intra frame interval


v1.1.6
minor quality tuning and support for delayless operation (media time=0) with SBR
exhaleApp: fixed very rare output file corruption after finishing encoding with SBR
exhaleApp: fixed compilation error under Fedora (issue #20) and stdin hickup issue
exhaleLib: fixed some quality issues in SBR modes, no changes in non-SBR modes


v1.1.5
exhaleApp: correct print-out of Unicode file names and paths, minor code cleanup
exhaleLib: minor tuning of immediate playout frames, no changes to audio quality
makefile: support for compilation of Universal 2 binaries on MacOS™ (C. Snowhill)


v1.1.4
exhaleApp: removed LUFS/dBFS command arguments again, code now automatic
exhaleApp: consider the working instead of application path if no path is specified
exhaleLib: reduce enc. delay to closest integer multiple of frame length (issue 15)
exhaleLib: very minor tuning of transient coding especially on male speech signals


v1.1.3
exhaleApp: allow specifying loudness (LUFS) and peak sample (dBFS) after preset
exhaleLib: write UsacConfig in immediate playout frames (increases compatibility)


v1.1.2
further improved file interoperability and seekability with some playback software
exhaleLib: write all frames in «stss» data as immediate playout frames (issue #15)


v1.1.1
slightly improved audio quality with SBR, better compatibility with some decoders
exhaleLib: increased frequency resolution of coded SBR envelopes, minor cleanup
exhaleLib: workaround for time differential coding bug in some xHE-AAC decoders


v1.1.0
addition of basic SBR functionality for lower-rate coding down to 18 kbps/channel
exhaleApp: add support for CVBR modes a—g for encoding with SBR functionality
exhaleApp: show «ARM» in header and '-v' command on corresponding platforms
exhaleLib: basic 2:1 SBR encoding with ccfl = 2048, minor fixes and code cleanups


Version 1.0.8 Oct. 2020, this release
minor quality improvements at low and high rates, some license text clarifications
exhaleApp: slightly improved loudness calculation for low and high sampling rates
exhaleLib: improved audio quality a bit for the lower and higher-rate CVBR modes
License: removed references to BSD text, clarified disclaimer and contributor text


Version 1.0.7 Aug. 2020, this release
minor bugfixes in bit-rate control and higher-rate coding at 32 kHz sampling rate
exhaleApp: add support for CVBR mode 0 at codec sampling rates below 44.1 kHz
exhaleApp: write complete MP4 «stss» data for improved compatibility (issue 13)
exhaleApp: higher accuracy of loudness estimation, better BS.1770-4 compliance


Version 1.0.6 July 2020, this release
bugfixes, improved quality on some transient signals, better decoder compatibility
exhaleApp: support for Extensible WAVE format, write MP4 «prol» data (issue 10)
exhaleApp: automatic downsampling of 48-kHz input to 32 kHz for CVBR mode 1
exhaleLib: fine-tuning of psychoacoustic model for difficult transient input signals


Version 1.0.5 June 2020
slightly reduced bit-rates with lower modes, better compatibility when using stdin
exhaleApp: support for Unicode text on Windows™, 44100 Hz with CVBR mode 1
exhaleApp: automatic upsampling of low-sample-rate input, fixed reader (issue 9)
exhaleLib: optimized noise filling tool for slightly lower bit-rates at CVBR mode <4
compilation: exhaleApp.exe -> exhale.exe (issue 8), support for Arm™, C header


Version 1.0.4 May 2020, this release
finalized basic joint-stereo and TNS coding functionality, quality and stability fixes
exhaleApp: support for 32000 Hz with CVBR mode 1, added '-v' version command
exhaleLib: completed audio quality fine-tuning for very tonal and transient signals
compilation: support for MinGW (issue 5) and cmake (via CMakeList files, issue 6)


Version 1.0.3 Apr. 2020
extended basic joint-stereo coding functionality for mid/high rates, minor bugfixes
exhaleLib: band adaptive joint-stereo coding for all CVBR modes, fixed rare crash
exhaleLib: audio quality fine-tuning, especially for very tonal and transient signals
makefile: -std=c++11 to allow for compilation with older versions of gcc (issue 4)


Version 1.0.2 Mar. 2020
added basic low/mid-rate joint-stereo coding functionality, bugfixes, and speedups
exhaleApp: support for input sampling rates of up to 48000 Hz with CVBR mode 2
exhaleLib: frame adaptive joint-stereo preprocessing and coding (CVBR mode <5)
exhaleLib: accelerated R/D opt. coding, stability and quality fixes (issues 2 and 3)


Version 1.0.1 Feb. 2020
improved low-bitrate coding efficiency and support for MPEG-D loudness metadata
exhaleApp: increased MP4 file versatility (issue 1) and calculation of loudness info
exhaleLib: backward compatible API extension to support writing of loudness info
exhaleLib: extended R/D optimized coding, improved short-transform quantization


Version 1.0.0 Jan. 2020
compilation fixes and executable printout changes for Linux and MacOS™ platform
exhaleApp: fixed reading of WAVE files including metadata after the «data» chunk
exhaleLib: some tuning of transform and noise level detection for transient signals
exhaleLib: support for export as DLL on Microsoft Windows™ (not tested, though)


Version 1.0RC Dec. 2019
initial release for testing with only basic channel-independent coding functionality
only support for Microsoft Windows™ (32-bit and 64-bit) platform provided so far.

