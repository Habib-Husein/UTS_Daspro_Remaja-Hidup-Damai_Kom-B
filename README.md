# 🕵️ Hoax Hunter

> **UTS_Daspro_Remaja-Hidup-Damai_Kom-B**
> by Kelompok **Remaja Hidup Damai**

Program konsol berbahasa **Pascal** untuk melatih pengguna mengenali berita hoax.
Proyek UTS Dasar Pemrograman DP3, Semester Ganjil T.A. 2026/2027, Program Studi Ilmu Komputer, Universitas Sumatera Utara.

---

## 👥 Anggota Kelompok

| Nama | NIM | KOM | Lab |
|------|-----|-----|-----|
| Habib Husein | 261401022 | B | 3 |
| Victor Chaste Nababan | 261401064 | B | 3 |
| Dzikri Bagus | 261401025 | B | 3 |

---

## ✨ Fitur Utama

1. **Menu Interaktif**: 4 pilihan (Mulai Investigasi, Buku Panduan, Rekor Skor, Keluar). Menu diulang dengan `repeat-until` sampai pemain memilih 4, pilihan diproses dengan `case-of`.
2. **Kuis Fakta / Opini / Hoaks**: 20 kasus diacak (Fisher-Yates) tiap permainan dan dijawab F/O/H dalam loop `for-to-do`. Benar +10 poin, salah −5 poin dan nyawa −1 (modal 5 nyawa). `continue` dipakai saat Skip (maks. 2x), `break` dipakai saat Menyerah (Q) atau nyawa habis.
3. **Soal Bonus**: terbuka jika 20 kasus selesai dengan nyawa tersisa, boleh ditolak. Benar +30, salah −15.
4. **Pangkat Agen & Rekapitulasi**: pangkat ditentukan dengan `nested-if` dari skor, sisa nyawa, dan hasil bonus. Rekap ditampilkan dalam 2 kolom.
5. **Arsip Pembahasan**: kunci jawaban, penjelasan, dan sumber dibuka dengan sandi dan ditampilkan per 3 kasus memakai `while-do`.
6. **Buku Panduan & Rekor Skor**: aturan main dan skor tertinggi selama sesi.

*#SemangatIKLC*
