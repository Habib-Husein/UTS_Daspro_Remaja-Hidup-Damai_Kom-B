{$H+}
program HoaxHunter;
uses crt;

const
  JML_SOAL_UTAMA = 20;
  IDX_BONUS      = 21;
  TOTAL_SOAL     = 21;

  MODAL_NYAWA    = 5;
  MODAL_SKIP     = 2;

  POIN_BENAR     = 10;
  POIN_SALAH     = -5;
  POIN_BONUS_BNR = 30;
  POIN_BONUS_SLH = -15;

  BATAS_SKOR_1   = 180;
  BATAS_SKOR_2   = 120;
  NYAWA_SENIOR   = 4;
  SOAL_PER_HAL   = 3;

  SANDI_ARSIP    = 'aku sayang mama';
  GARIS_TEBAL    = '====================================================================';
  GARIS_TIPIS    = '--------------------------------------------------------------------';

type
  TSoal = record
    kategori: string;
    baris1, baris2, baris3: string;
    kunci: char;
    bahas1, bahas2: string;
    sumber: string;
  end;

  TBankSoal = array[1..TOTAL_SOAL] of TSoal;
  TJawaban  = array[1..TOTAL_SOAL] of char;

procedure BersihkanBuffer;
begin
  while keypressed do readkey;
end;

function BacaTombol(const diizinkan: string): char;
var
  ch: char;
begin
  BersihkanBuffer;
  repeat
    ch := upcase(readkey);
    if ch = #0 then readkey;
  until Pos(ch, diizinkan) > 0;
  BacaTombol := ch;
end;

procedure TungguEnter;
var
  ch: char;
begin
  BersihkanBuffer;
  repeat
    ch := readkey;
    if ch = #0 then readkey;
  until ch = #13;
end;

procedure Loading(ms: integer);
const
  TEKS_LOAD = 'LOADING...';
var
  siklus, k: integer;
begin
  clrscr;
  textcolor(white);
  for siklus := 1 to 2 do
  begin
    gotoxy(29, 12);
    write('            ');
    for k := 1 to length(TEKS_LOAD) do
    begin
      gotoxy(28 + k, 12);
      write(TEKS_LOAD[k]);
      delay(ms);
    end;
  end;
  clrscr;
  BersihkanBuffer;
end;

procedure IsiSatuSoal(var s: TSoal; const kat, b1, b2, b3: string;
                      knc: char; const bh1, bh2, smb: string);
begin
  s.kategori := kat;
  s.baris1   := b1;
  s.baris2   := b2;
  s.baris3   := b3;
  s.kunci    := knc;
  s.bahas1   := bh1;
  s.bahas2   := bh2;
  s.sumber   := smb;
end;

procedure MuatBankSoal(var bank: TBankSoal);
begin
  IsiSatuSoal(bank[1], 'Kebijakan Pemerintah & Isu Nasional',
    '"Kementerian Keuangan mencatat program Makan Bergizi Gratis',
    ' menyerap anggaran Rp 51,5 triliun sepanjang 2025, atau sekitar',
    ' 72,5 persen dari total pagu Rp 71 triliun."', 'F',
    'Fakta resmi laporan realisasi anggaran Kemenkeu per 31 Des 2025.',
    'Dari pagu awal Rp 71 triliun, serapan riil tercatat Rp 51,5 triliun.',
    'https://money.kompas.com/read/2026/01/08/191208526/program-mbg-serap-rp-515-t-hingga-desember-2025-cuma-725-persen');

  IsiSatuSoal(bank[2], 'Kebijakan Pemerintah & Isu Nasional',
    '"Badan Pemeriksa Keuangan menemukan sisa dana program Makan',
    ' Bergizi Gratis tahun 2025 sebesar Rp 34,33 miliar pada mitra',
    ' pelayanan belum disetorkan ke kas negara."', 'F',
    'Fakta hasil audit resmi BPK yang dipublikasikan 16 Oktober 2026.',
    'BPK merekomendasikan Kepala BGN segera menyetor sisa dana tersebut.',
    'https://www.bpk.go.id/news/bpk-dorong-percepatan-penyetoran-sisa-dana-mbg');

  IsiSatuSoal(bank[3], 'Kebijakan Pemerintah & Isu Nasional',
    '"Kenaikan tarif Pajak Pertambahan Nilai menjadi 12 persen',
    ' berpotensi menghambat pertumbuhan ekonomi nasional dan sebaiknya',
    ' baru diterapkan saat daya beli masyarakat benar-benar stabil."', 'O',
    'Opini & proyeksi analitis ekonom Indef (A. Manap & Esther Sri).',
    'Kata kunci penanda opini: "berpotensi menghambat" dan "sebaiknya".',
    'https://sultra.antaranews.com/berita/487686/indef-kenaikan-ppn-12-persen-diterapkan-saat-ekonomi-masyarakat-telah-stabil');

  IsiSatuSoal(bank[4], 'Kebijakan Pemerintah & Isu Nasional',
    '"Pemerintah bersama Kementerian Sosial resmi menghapus seluruh',
    ' program bantuan sosial seperti PKH dan BLT pada pertengahan 2026',
    ' untuk mengalihkan anggarannya ke Makan Bergizi Gratis."', 'H',
    'Hoaks! Dibantah Kepala Badan Komunikasi RI & Mensos Saifullah Yusuf.',
    'Seluruh program bansos reguler tetap berjalan tanpa pengalihan dana.',
    'https://www.kompas.com/cekfakta/read/2026/07/17/121800682/-hoaks-prabowo-dan-kemensos-hapus-seluruh-bansos-dan-dialihkan-ke-mbg');

  IsiSatuSoal(bank[5], 'Fakta Unik & Isu Negara Dunia',
    '"Status Islandia sebagai negara bebas nyamuk resmi runtuh pada',
    ' akhir Oktober 2025 setelah ilmuwan menemukan tiga ekor nyamuk',
    ' spesies Culiseta annulata di wilayah tersebut."', 'F',
    'Fakta ilmiah konfirmasi Institut Sejarah Alam Islandia (Okt 2025).',
    'Kini hanya benua Antartika yang berstatus wilayah bebas nyamuk.',
    'https://www.ni.is/en/news/2025/10/mosquitoes-found-in-iceland');

  IsiSatuSoal(bank[6], 'Fakta Unik & Isu Negara Dunia',
    '"Rahasia utama yang menjadikan Finlandia negara paling nyaman',
    ' dan bahagia di dunia bukanlah kekayaan materi, melainkan',
    ' ekspektasi hidup yang rendah untuk tidak mengejar kesempurnaan."', 'O',
    'Opini & interpretasi subjektif penulis Kristinutora Sprinkel saat',
    'mengulas filosofi hidup warga Finlandia (bukan ukuran statistik).',
    'https://lifestyle.kompas.com/read/2026/07/07/213000020/finlandia-9-kali-jadi-negara-paling-bahagia-ternyata-ini-filosofi-hidup');

  IsiSatuSoal(bank[7], 'Fakta Unik & Isu Negara Dunia',
    '"Kota Wina merupakan tempat tinggal paling nyaman di dunia dengan',
    ' infrastruktur sempurna, sedangkan kelemahan satu-satunya kota',
    ' tersebut hanyalah minimnya acara olahraga berskala besar."', 'O',
    'Opini evaluatif atas profil kelayakan huni Kota Wina, Austria.',
    'Diksi "paling nyaman" & "kelemahan satu-satunya" bersifat subjektif.',
    'https://www.economist.com/graphic-detail/global-liveability-index');

  IsiSatuSoal(bank[8], 'Fakta Unik & Isu Negara Dunia',
    '"Tembok Besar China merupakan satu-satunya bangunan buatan',
    ' manusia di Bumi yang dapat dilihat secara langsung dengan mata',
    ' telanjang oleh astronaut dari luar angkasa."', 'H',
    'Hoaks/Mitos populer yang telah dibantah resmi oleh NASA & astronaut.',
    'Tembok Besar China tidak terlihat mata telanjang dari orbit Bumi.',
    'https://www.detik.com/edu/detikpedia/d-6582372/4-bangunan-yang-terlihat-dari-angkasa-luar-tembok-besar-cina-tidak-termasuk');

  IsiSatuSoal(bank[9], 'Artis, Musik, Film & Pop Culture',
    '"Film komedi Agak Laen: Menyala Pantiku! resmi menumbangkan',
    ' rekor Avengers: Endgame di bioskop Indonesia setelah meraup',
    ' 10.980.933 penonton pada hari ke-104 penayangannya."', 'F',
    'Fakta rekor box office nasional yang tercatat resmi Maret 2026.',
    'Melampaui capaian Avengers: Endgame (10.976.338 penonton).',
    'https://entertainment.kompas.com/read/2026/03/11/131007466/agak-laen-2-tumbangkan-avengers-endgame-di-box-office-indonesia-raup');

  IsiSatuSoal(bank[10], 'Artis, Musik, Film & Pop Culture',
    '"Kesuksesan besar film biopik Oppenheimer di tangga box office',
    ' dunia dinilai akan mengakhiri dominasi era film waralaba dan',
    ' memulai babak baru industri sinema."', 'O',
    'Opini & prediksi subjektif sutradara Christopher Nolan tentang',
    'masa depan tren sinema global (spekulasi yang belum tentu terjadi).',
    'https://variety.com/2024/film/news/christopher-nolan-oppenheimer-post-franchise-era-1235894012/');

  IsiSatuSoal(bank[11], 'Artis, Musik, Film & Pop Culture',
    '"Penggunaan kamera IMAX 70mm pada film Oppenheimer menghasilkan',
    ' ketajaman gambar terbaik yang tak tertandingi sekaligus',
    ' menciptakan pengalaman sinematik paling unik."', 'O',
    'Opini subjektif Christopher Nolan dan aktor Robert Downey Jr.',
    'Klaim estetika "terbaik" & "paling unik" adalah apresiasi artistik.',
    'https://www.imax.com/news/oppenheimer-imax-70mm-experience');

  IsiSatuSoal(bank[12], 'Artis, Musik, Film & Pop Culture',
    '"Penyanyi dangdut senior Inul Daratista mengembuskan napas',
    ' terakhirnya pada 16 April 2025 setelah sempat menjalani',
    ' perawatan medis secara intensif di sebuah rumah sakit."', 'H',
    'Hoaks! Faktanya Inul Daratista dalam keadaan sehat dan masih aktif',
    'berziarah ke makam mendiang Titiek Puspa pada 17 April 2025.',
    'https://www.kompas.com/cekfakta/read/2025/04/17/145800182/-hoaks-inul-daratista-meninggal-dunia-pada-16-april-2025');

  IsiSatuSoal(bank[13], 'Teknologi, AI & Keamanan Siber',
    '"Pesan singkat atau SMS pertama di dunia dikirimkan melalui',
    ' jaringan Vodafone pada 3 Desember 1992 menggunakan komputer',
    ' pribadi dengan kalimat singkat bertuliskan Merry Christmas."', 'F',
    'Fakta sejarah telekomunikasi dunia yang terverifikasi.',
    'Dikirim oleh insinyur Neil Papworth dari PC ke ponsel di Inggris.',
    'https://www.vodafone.com/news/technology/first-sms-30-years');

  IsiSatuSoal(bank[14], 'Teknologi, AI & Keamanan Siber',
    '"Perkembangan pesat ekosistem kecerdasan buatan dan pembangunan',
    ' pabrik chip di masa depan dinilai akan membuka berbagai peluang',
    ' lapangan kerja baru dengan tingkat gaji tinggi."', 'O',
    'Opini & proyeksi optimis CEO Nvidia Jensen Huang soal pasar kerja AI.',
    'Bersifat spekulatif; survei WEF mencatat 54% eksekutif justru cemas.',
    'https://money.kompas.com/read/2026/01/22/215505226/jensen-huang-pabrik-chip-dan-ai-buka-peluang-kerja-dengan-gaji-tinggi');

  IsiSatuSoal(bank[15], 'Teknologi, AI & Keamanan Siber',
    '"Kepolisian resmi mengirimkan dokumen surat tilang elektronik',
    ' atau ETLE berformat aplikasi APK secara langsung ke nomor',
    ' WhatsApp pelanggar lalu lintas untuk mempercepat penindakan."', 'H',
    'Hoaks modus phishing APK pencuri data pribadi dan saldo rekening!',
    'Polri menegaskan surat konfirmasi ETLE resmi dikirim via PT Pos.',
    'https://korlantas.polri.go.id/news/waspada-penipuan-etle-format-apk-whatsapp/');

  IsiSatuSoal(bank[16], 'Teknologi, AI & Keamanan Siber',
    '"Kementerian Sosial resmi membuka tautan verifikasi digitalisasi',
    ' bantuan langsung tunai Rp 900.000 pada Oktober 2026 yang',
    ' mewajibkan warga memasukkan nama serta nomor akun Telegram."', 'H',
    'Hoaks phishing pencurian akun Telegram yang dibongkar Oktober 2026!',
    'Kemensos tidak pernah meminta kredensial Telegram untuk bansos.',
    'https://www.komdigi.go.id/berita/berita-hoaks/detail/hoaks-tautan-klaim-blt-telegram');

  IsiSatuSoal(bank[17], '"Broadcast" Grup WA & Viral Medsos',
    '"Kementerian Kesehatan dan dokter mata merekomendasikan rumus',
    ' 20-20-20, yaitu mengistirahatkan mata setiap 20 menit selama',
    ' 20 detik dengan menatap objek berjarak enam meter."', 'F',
    'Fakta panduan kesehatan mata resmi dari Kemenkes & ahli oftalmologi',
    'untuk merelaksasi otot mata dan mencegah Computer Vision Syndrome.',
    'https://ayosehat.kemkes.go.id/cegah-mata-lelah-dengan-aturan-20-20-20');

  IsiSatuSoal(bank[18], '"Broadcast" Grup WA & Viral Medsos',
    '"Metode puasa intermiten atau intermittent fasting merupakan',
    ' gaya hidup paling menyenangkan dan paling ideal bagi pekerja',
    ' sibuk untuk menjaga kebugaran tubuh sehari-hari."', 'O',
    'Opini subjektif pegiat diet. Klaim "paling menyenangkan" & "ideal"',
    'bersifat relatif bagi tiap individu dan bukan parameter medis.',
    'https://lifestyle.kompas.com/read/2026/02/16/210000020/studi-ungkap-diet-intermittent-fasting-tak-lebih-ampuh-dari-diet-biasa');

  IsiSatuSoal(bank[19], '"Broadcast" Grup WA & Viral Medsos',
    '"Meminum campuran air kelapa muda, perasan jeruk nipis, dan satu',
    ' sendok makan garam terbukti secara klinis mampu melenyapkan',
    ' virus Covid-19 dalam waktu satu jam."', 'H',
    'Hoaks pesan berantai! Dibantah Mafindo (TurnBackHoax) dan pakar',
    'farmakologi UGM Prof. Dr. Zullies Ikawati, Apt.',
    'https://turnbackhoax.id/articles/7013-salah-campuran-air-kelapa-muda-jeruk-nipis-dan-garam-dapat-menyembuhkan-covid-19');

  IsiSatuSoal(bank[20], '"Broadcast" Grup WA & Viral Medsos',
    '"Kebiasaan minum air es, makan mentimun, dan keramas saat sedang',
    ' haid akan menyisakan darah di dinding rahim yang memicu kanker',
    ' rahim dalam sepuluh tahun."', 'H',
    'Hoaks medis berulang! Dokter Spesialis Obgyn dr. Harry Parathon,',
    'SpOG menegaskan kebiasaan tersebut sama sekali tidak memicu kanker.',
    'https://turnbackhoax.id/articles/22140-salah-minum-air-es-dan-keramas-saat-haid-memicu-kanker-rahim');

  { Indeks ke-21: Khusus Soal Bonus }
  IsiSatuSoal(bank[IDX_BONUS], 'Negara/Pemerintah & Teknologi',
    '"El Salvador mencatatkan sejarah sebagai negara pertama di dunia',
    ' yang secara resmi mengesahkan mata uang kripto Bitcoin menjadi',
    ' alat pembayaran sah melalui persetujuan Kongres."', 'F',
    'Fakta regulasi kenegaraan & teknologi! Disahkan Kongres El Salvador',
    'pada Juni 2021 dan berlaku efektif mulai 7 September 2021.',
    'https://www.reuters.com/world/americas/el-salvador-approves-first-law-bitcoin-legal-tender-2021-06-09/');
end;

{ Mengacak urutan 20 soal utama (Fisher-Yates Shuffle) agar kunci tidak tertebak }
procedure AcakSoalUtama(var bank: TBankSoal);
var
  i, acak: integer;
  temp: TSoal;
begin
  for i := JML_SOAL_UTAMA downto 2 do
  begin
    acak := Random(i) + 1;
    temp := bank[i];
    bank[i] := bank[acak];
    bank[acak] := temp;
  end;
end;

function StatusSingkat(jwb, knc: char): string;
begin
  case jwb of
    'S': StatusSingkat := 'SKIP ( 0)';
    'Q': StatusSingkat := 'QUIT ( 0)';
    '-': StatusSingkat := ' -   ( 0)';
  else
    if jwb = knc then
      StatusSingkat := 'BENAR(+10)'
    else
      StatusSingkat := 'SALAH( -5)';
  end;
end;

procedure CetakSoal(const s: TSoal);
begin
  writeln(' ', s.baris1);
  writeln(' ', s.baris2);
  writeln(' ', s.baris3);
end;

procedure JalankanKuisUtama(const bank: TBankSoal; var jawab: TJawaban;
                            var skor, nyawa, kuotaSkip, terjawab: integer;
                            var menyerah: boolean);
var
  j: integer;
  ch: char;
begin
  for j := 1 to JML_SOAL_UTAMA do
  begin
    clrscr;
    textcolor(yellow);
    writeln(' KASUS ', j:2, ' DARI ', JML_SOAL_UTAMA, ' | Kategori: ', bank[j].kategori);
    textcolor(lightcyan);
    writeln(' [Skor: ', skor:3, ']   [Nyawa: ', nyawa, '/', MODAL_NYAWA, ']   [Kuota Skip (S): ', kuotaSkip, ']');
    writeln(' ', GARIS_TEBAL);
    textcolor(white);
    writeln;
    CetakSoal(bank[j]);
    writeln;
    writeln(' ', GARIS_TIPIS);
    writeln(' Pilihan: ');
    textcolor(yellow);
    writeln(' [F] Fakta  [O] Opini  [H] Hoaks');
    textcolor(lightred);
    writeln('     [S] Skip  [Q] Menyerah');
    textcolor(white);
    write(' Keputusan Agen: ');

    ch := BacaTombol('FOHSQ');
    writeln(ch);
    terjawab := j;

    { Kontrol BREAK #1: Pemain memilih menyerah (Q) }
    if ch = 'Q' then
    begin
      jawab[j] := 'Q';
      menyerah := true;
      textcolor(lightred);
      writeln;
      writeln(' Anda memilih menghentikan investigasi lebih awal!');
      writeln(' Tekan [ENTER] untuk menuju rekapitulasi...');
      TungguEnter;
      break;
    end;

    { Kontrol CONTINUE: Pemain memilih Skip (S) }
    if ch = 'S' then
    begin
      if kuotaSkip > 0 then
      begin
        kuotaSkip := kuotaSkip - 1;
        jawab[j] := 'S';
        textcolor(yellow);
        writeln;
        writeln(' >> Kasus dilewati! Kuota Skip tersisa: ', kuotaSkip);
        textcolor(white);
        writeln(' Tekan [ENTER] untuk lanjut ke kasus berikutnya...');
        TungguEnter;
        continue;
      end
      else
      begin
        textcolor(lightred);
        writeln(' Kuota Skip sudah habis! Wajib pilih F, O, atau H.');
        write(' Keputusan Agen: ');
        ch := BacaTombol('FOH');
        writeln(ch);
      end;
    end;

    jawab[j] := ch;
    writeln;

    if jawab[j] = bank[j].kunci then
    begin
      skor := skor + POIN_BENAR;
      textcolor(lightgreen);
      writeln(' >> TEPAT! (+', POIN_BENAR, ' Poin)');
    end
    else
    begin
      skor := skor + POIN_SALAH;
      nyawa := nyawa - 1;
      textcolor(lightred);
      writeln(' >> KELIRU! (', POIN_SALAH, ' Poin, Nyawa berkurang 1)');
    end;

    { Kontrol BREAK #2: Nyawa habis di tengah permainan }
    if nyawa <= 0 then
    begin
      writeln;
      textcolor(lightred);
      writeln(' ', GARIS_TEBAL);
      writeln('   KREDIBILITAS ANDA HABIS (NYAWA = 0)! INVESTIGASI DIHENTIKAN!     ');
      writeln(' ', GARIS_TEBAL);
      textcolor(yellow);
      writeln(' Tekan [ENTER] untuk melihat hasil akhir...');
      TungguEnter;
      break;
    end;

    textcolor(white);
    writeln(' Tekan [ENTER] untuk lanjut ke kasus berikutnya...');
    TungguEnter;
  end;
end;

procedure JalankanSoalBonus(const soalBonus: TSoal; var jawabBonus: char;
                            var skor: integer; var ikutBonus, menangBonus: boolean);
var
  pilBonus, ch: char;
begin
  clrscr;
  textcolor(yellow);
  writeln(' ', GARIS_TEBAL);
  writeln(' =                        SOAL BONUS TERBUKA!                       =');
  writeln(' ', GARIS_TEBAL);
  textcolor(white);
  writeln(' Selamat! Anda berhasil bertahan melewati ', JML_SOAL_UTAMA, ' kasus utama.');
  writeln(' Aturan Soal Bonus: Benar (+', POIN_BONUS_BNR, ' Poin) | Salah (', POIN_BONUS_SLH, ' Poin)');
  writeln;
  write(' Apakah Anda ingin mengambil Soal Bonus ini? (Y/T): ');

  pilBonus := BacaTombol('YT');
  writeln(pilBonus);

  if pilBonus = 'Y' then
  begin
    ikutBonus := true;
    clrscr;
    textcolor(yellow);
    writeln(' SOAL BONUS | Kategori: ', soalBonus.kategori);
    writeln(' ', GARIS_TEBAL);
    textcolor(white);
    writeln;
    CetakSoal(soalBonus);
    writeln;
    writeln(' ', GARIS_TIPIS);
    write(' Pilih Jawaban [F] Fakta / [O] Opini / [H] Hoaks: ');

    ch := BacaTombol('FOH');
    writeln(ch);
    jawabBonus := ch;
    writeln;

    if ch = soalBonus.kunci then
    begin
      skor := skor + POIN_BONUS_BNR;
      menangBonus := true;
      textcolor(lightgreen);
      writeln(' >> LUAR BIASA! Soal Bonus berhasil dipecahkan (+', POIN_BONUS_BNR, ' Poin)');
    end
    else
    begin
      skor := skor + POIN_BONUS_SLH;
      textcolor(lightred);
      writeln(' >> KURANG TEPAT! Anda terjebak pada Soal Bonus (', POIN_BONUS_SLH, ' Poin)');
    end;

    textcolor(white);
    writeln(' Tekan [ENTER] untuk menuju rekapitulasi akhir...');
    TungguEnter;
  end;
end;

{ Penentuan Pangkat Agen dengan struktur Nested-If }
function HitungPangkat(skor, nyawa: integer; menangBonus, menyerah: boolean): string;
begin
  if (nyawa > 0) and (not menyerah) then
  begin
    if skor >= BATAS_SKOR_1 then
    begin
      if menangBonus then
        HitungPangkat := 'DIREKTUR UTAMA ANTI-HOAKS (LEGEND)'
      else
        HitungPangkat := 'KOMISARIS INTELIJEN INFORMASI';
    end
    else if skor >= BATAS_SKOR_2 then
    begin
      if nyawa >= NYAWA_SENIOR then
        HitungPangkat := 'AGEN SENIOR INVESTIGASI SIBER'
      else
        HitungPangkat := 'ANALIS FAKTA LAPANGAN';
    end
    else
      HitungPangkat := 'AGEN JUNIOR (PERLU LATIHAN LITERASI)';
  end
  else
  begin
    if menyerah then
      HitungPangkat := 'AGEN MUNDUR (INVESTIGASI DIBATALKAN)'
    else
      HitungPangkat := 'AGEN NONAKTIF (KEHABISAN KREDIBILITAS)';
  end;
end;

{ Menampilkan rekap 2 kolom (10 baris) agar muat sempurna di konsol 80x25 }
procedure TampilRekap(const nama, pangkat: string; const bank: TBankSoal;
                      const jawab: TJawaban; skor, nyawa: integer;
                      ikutBonus, menangBonus: boolean);
var
  baris, idxKanan: integer;
begin
  clrscr;
  textcolor(yellow);
  writeln(' REKAPITULASI INVESTIGASI AGEN: ', upcase(nama));
  writeln(' ', GARIS_TEBAL);
  textcolor(white);

  for baris := 1 to (JML_SOAL_UTAMA div 2) do
  begin
    idxKanan := baris + (JML_SOAL_UTAMA div 2);
    write(' Kasus ', baris:2, ' [', jawab[baris], '] : ',
          StatusSingkat(jawab[baris], bank[baris].kunci):10);
    writeln('   |   Kasus ', idxKanan:2, ' [', jawab[idxKanan], '] : ',
            StatusSingkat(jawab[idxKanan], bank[idxKanan].kunci):10);
  end;

  if ikutBonus then
  begin
    write(' Soal Bonus [', jawab[IDX_BONUS], '] -> ');
    if menangBonus then
    begin
      textcolor(lightgreen);
      writeln('BENAR (+', POIN_BONUS_BNR, ')');
    end
    else
    begin
      textcolor(lightred);
      writeln('SALAH (', POIN_BONUS_SLH, ')');
    end;
    textcolor(white);
  end;

  textcolor(lightcyan);
  writeln(' ', GARIS_TEBAL);
  textcolor(yellow);
  writeln(' TOTAL SKOR AKHIR : ', skor, ' Poin (Sisa Nyawa: ', nyawa, '/', MODAL_NYAWA, ')');
  writeln(' PANGKAT AGEN     : ', pangkat);
  textcolor(lightcyan);
  writeln(' ', GARIS_TEBAL);
end;

{ Menampilkan pembahasan dengan perulangan WHILE-DO dan paginasi }
procedure BukaArsipPembahasan(const bank: TBankSoal; const jawab: TJawaban;
                              terjawab: integer; ikutBonus: boolean);
var
  idx, tampilCount: integer;
  lanjutBonus: boolean;
begin
  Loading(20);
  idx := 1;
  tampilCount := 0;
  lanjutBonus := ikutBonus;

  while (idx <= terjawab) or lanjutBonus do
  begin
    if idx <= terjawab then
    begin
      textcolor(yellow);
      writeln(' [Kasus #', idx:2, '] Kunci: ', bank[idx].kunci,
              ' | Jawaban Anda: ', jawab[idx]);
      textcolor(white);
      writeln('  PENJELASAN: ', bank[idx].bahas1);
      writeln('              ', bank[idx].bahas2);
      writeln('  SUMBER    : ', bank[idx].sumber);
      writeln(' ', GARIS_TIPIS);
      idx := idx + 1;
    end
    else if lanjutBonus then
    begin
      textcolor(yellow);
      writeln(' [SOAL BONUS] Kunci: ', bank[IDX_BONUS].kunci,
              ' | Jawaban Anda: ', jawab[IDX_BONUS]);
      textcolor(white);
      writeln('  PENJELASAN: ', bank[IDX_BONUS].bahas1);
      writeln('              ', bank[IDX_BONUS].bahas2);
      writeln('  SUMBER    : ', bank[IDX_BONUS].sumber);
      writeln(' ', GARIS_TIPIS);
      lanjutBonus := false;
    end;

    tampilCount := tampilCount + 1;
    if (tampilCount mod SOAL_PER_HAL = 0) and ((idx <= terjawab) or lanjutBonus) then
    begin
      textcolor(lightcyan);
      writeln(' Tekan [ENTER] untuk halaman penjelasan berikutnya...');
      TungguEnter;
      clrscr;
    end;
  end;

  textcolor(yellow);
  writeln(' Tekan [ENTER] untuk kembali ke Menu Utama...');
  TungguEnter;
end;

procedure Play(var rekorSkor: integer);
var
  bank: TBankSoal;
  jawab: TJawaban;
  nama, pangkat, inputSandi: string;
  i, skor, nyawa, kuotaSkip, terjawab: integer;
  ikutBonus, menangBonus, menyerah: boolean;
begin
  Loading(25);
  textcolor(white);
  write(' MASUKKAN NAMA AGEN: ');
  readln(nama);
  if nama = '' then nama := 'Agen Anonim';

  MuatBankSoal(bank);
  AcakSoalUtama(bank);
  for i := 1 to TOTAL_SOAL do jawab[i] := '-';

  skor        := 0;
  nyawa       := MODAL_NYAWA;
  kuotaSkip   := MODAL_SKIP;
  terjawab    := 0;
  ikutBonus   := false;
  menangBonus := false;
  menyerah    := false;

  clrscr;
  textcolor(lightcyan);
  writeln(' ', GARIS_TEBAL);
  writeln(' SELAMAT BERTUGAS, AGEN ', upcase(nama), '!');
  writeln(' Modal Awal: ', MODAL_NYAWA, ' Nyawa | ', MODAL_SKIP,
          ' Kuota Skip [S] | Tekan [Q] jika Menyerah');
  writeln(' ', GARIS_TEBAL);
  textcolor(yellow);
  writeln(' Tekan [ENTER] untuk membuka Kasus #1...');
  TungguEnter;

  JalankanKuisUtama(bank, jawab, skor, nyawa, kuotaSkip, terjawab, menyerah);

  if (nyawa > 0) and (not menyerah) then
    JalankanSoalBonus(bank[IDX_BONUS], jawab[IDX_BONUS], skor, ikutBonus, menangBonus);

  pangkat := HitungPangkat(skor, nyawa, menangBonus, menyerah);
  if skor > rekorSkor then rekorSkor := skor;

  Loading(20);
  TampilRekap(nama, pangkat, bank, jawab, skor, nyawa, ikutBonus, menangBonus);

  textcolor(white);
  writeln(' [ARSIP TERKUNCI] Masukkan Sandi Rahasia Agen untuk membuka Kunci');
  writeln(' Jawaban & Sumber (Petunjuk sandi ada di Buku Panduan Agen).');
  write(' >> Sandi Rahasia (atau tekan [ENTER] untuk lewati): ');
  BersihkanBuffer;
  readln(inputSandi);

  if lowercase(inputSandi) = SANDI_ARSIP then
    BukaArsipPembahasan(bank, jawab, terjawab, ikutBonus)
  else
  begin
    textcolor(lightred);
    writeln(' Sandi tidak sesuai/dilewati. Arsip Kunci Jawaban tetap terkunci!');
    delay(1200);
  end;
  clrscr;
end;

procedure TampilanMenu;
begin
  textcolor(lightcyan);
  writeln(' ', GARIS_TEBAL);
  writeln(' =                   HOAX HUNTER : BATTLE OF TRUTH                  =');
  writeln(' ', GARIS_TEBAL);
  textcolor(white);
  writeln('  [1] MULAI INVESTIGASI (PLAY GAME)');
  writeln('  [2] BUKU PANDUAN AGEN (INSTRUCTIONS)');
  writeln('  [3] REKOR SKOR TERTINGGI SESI INI');
  writeln('  [4] KELUAR PROGRAM (QUIT)');
  writeln(' ', GARIS_TIPIS);
  write('  Pilih Menu (1-4): ');
end;

procedure Instruksi;
begin
  Loading(25);
  textcolor(lightcyan);
  writeln(' ', GARIS_TEBAL);
  writeln(' =                        BUKU PANDUAN AGEN                         =');
  writeln(' ', GARIS_TEBAL);
  textcolor(white);
  writeln(' 1. Klasifikasikan ', JML_SOAL_UTAMA, ' kasus acak ke dalam kategori berikut:');
  writeln('    [F] FAKTA : Klaim objektif dengan bukti data/rekam jejak valid.');
  writeln('    [O] OPINI : Penilaian subjektif atau proyeksi masa depan.');
  writeln('    [H] HOAKS : Informasi palsu, mitos, atau modus phishing siber.');
  writeln(' 2. Aturan Poin, Kredibilitas (Nyawa), & Kontrol Khusus:');
  writeln('    - Benar : +', POIN_BENAR, ' Poin | Salah : ', POIN_SALAH,
          ' Poin & Nyawa -1 (Modal: ', MODAL_NYAWA, ' Nyawa)');
  writeln('    - [S]   : SKIP / Lewati soal tanpa penalti (Maksimal ', MODAL_SKIP, 'x)');
  writeln('    - [Q]   : MENYERAH / Hentikan investigasi lebih awal');
  writeln('    - Tekan [ENTER] setelah menjawab tiap soal untuk lanjut.');
  writeln(' 3. Soal Bonus (Bebas pilih ambil/tidak jika lulus ', JML_SOAL_UTAMA, ' soal):');
  writeln('    - Jawaban Benar : +', POIN_BONUS_BNR, ' Poin | Jawaban Salah : ', POIN_BONUS_SLH, ' Poin');
  writeln(' 4. Sandi Pembuka Kunci Jawaban & Sumber di Akhir Permainan:');
  textcolor(yellow);
  writeln('    Ketik kalimat rahasia: "', SANDI_ARSIP, '"');
  textcolor(lightcyan);
  writeln(' ', GARIS_TEBAL);
  textcolor(white);
  writeln(' Tekan [ENTER] untuk kembali ke Menu Utama...');
  TungguEnter;
  clrscr;
end;

procedure LihatSkor(rekorSkor: integer);
begin
  clrscr;
  textcolor(lightcyan);
  writeln(' ', GARIS_TEBAL);
  writeln(' =                  REKOR SKOR TERTINGGI SESI INI                   =');
  writeln(' ', GARIS_TEBAL);
  textcolor(yellow);
  writeln('  Skor Tertinggi Saat Ini : ', rekorSkor, ' Poin');
  textcolor(lightcyan);
  writeln(' ', GARIS_TEBAL);
  textcolor(white);
  writeln(' Tekan [ENTER] untuk kembali ke Menu Utama...');
  TungguEnter;
  clrscr;
end;

procedure TampilOpening;
begin
  clrscr;
  textcolor(lightcyan);
  writeln(' ', GARIS_TEBAL);
  writeln('                    HOAX HUNTER : BATTLE OF TRUTH                    ');
  writeln('              SIMULATOR KETAHANAN KOGNITIF & CEK FAKTA               ');
  writeln(' ', GARIS_TEBAL);
  textcolor(yellow);
  writeln('                    TEKAN [ENTER] UNTUK MEMULAI                      ');
  writeln(' ', GARIS_TEBAL);
  TungguEnter;

  Loading(25);

  textcolor(lightred);
  writeln('                           WARNING !!!!                              ');
  writeln(' ', GARIS_TEBAL);
  textcolor(yellow);
  writeln(' Game Hoax Hunter memuat informasi dan isu yang terinspirasi dari');
  writeln(' peristiwa dunia nyata hingga tahun 2026, serta fakta sejarah,');
  writeln(' sains populer, budaya pop, dan modus kejahatan siber.');
  writeln;
  writeln(' Sebagian soal dirancang menggunakan jebakan kognitif (cognitive');
  writeln(' traps) berupa opini tanpa atribusi tokoh maupun fakta unik yang');
  writeln(' terdengar kontra-intuitif.');
  writeln;
  writeln(' Pemain dituntut berpikir kritis, mengenali klaim subjektif atau');
  writeln(' prediktif, serta mewaspadai rekayasa sosial (phishing).');
  textcolor(lightred);
  writeln(' ', GARIS_TEBAL);
  textcolor(white);
  writeln(' Tekan [ENTER] untuk masuk ke Menu Utama...');
  TungguEnter;
  clrscr;
end;

var
  pilihanMenu: char;
  skorTertinggi: integer;
begin
  Randomize;
  skorTertinggi := 0;
  TampilOpening;

  repeat
    TampilanMenu;
    pilihanMenu := BacaTombol('1234');
    writeln(pilihanMenu);

    case pilihanMenu of
      '1': Play(skorTertinggi);
      '2': Instruksi;
      '3': LihatSkor(skorTertinggi);
      '4': begin
             clrscr;
             textcolor(lightgreen);
             writeln(' ', GARIS_TEBAL);
             writeln('         TERIMA KASIH TELAH MENJAGA RUANG DIGITAL KITA!              ');
             writeln(' ', GARIS_TEBAL);
             textcolor(white);
           end;
    end;
  until pilihanMenu = '4';
end.