1. Variabel dan Konstanta:
    Apa perbedaan antara variabel dan konstanta dalam Swift?
   Value variabel dapat diubah sedangkan value dari konstanta tidak.
    Bagaimana Anda mendeklarasikan variabel dan konstanta dalam Swift?
   var variable = "Hello", let variable = 5.
    Apa itu "type inference," dan bagaimana ia berfungsi dalam deklarasi variabel?
   menentukan tipe data secara otomatis tanpa menyebut secara eksplisit.
    Bagaimana Anda mengubah nilai variabel yang telah dideklarasikan?
   var variable: String = "" || var variable = "Hi"
   variable = "Hello"
2. Enum:
    Apa itu enum (enumeration) dalam Swift, dan apa gunanya?
   untuk mendefinisikan satu nilai data yang dapat mewakili tipe data.
    Apa perbedaan antara enum dengan associated values dan enum dengan raw values?
   associated values untuk menyimpan data tambahan sedangkan raw values untuk data yang konsisten.
    Bagaimana Anda mendefinisikan enum dengan kasus-kasus yang berbeda?
   enum Item{
   case Milk
   case Juice
   case Fruits
   }
   enum Item{
   case Milk, Juice, Fruits
   }
    Bagaimana Anda mengakses nilai-nilai yang terkait dengan kasus enum?
   menggunakan conditions, if-else maupun switch case.
3. Kondisi:
    Apa yang dimaksud dengan pernyataan if, else if, dan else dalam Swift?
   kasus yang memerlukan kondisi, if else pengecekan bisa menggunakan simbol atau opeartor seperti <, >, =, ==.
    Bagaimana Anda menggunakan pernyataan switch dalam Swift?
   switch case ini digunakan untuk mengecek data yang tipenya karakter dan juga integer. 
    Apa itu "pattern matching" dalam konteks switch statement?
   menentukan pola yang cocok untuk dieksekusi.
    Bagaimana Anda mengatasi situasi di mana tidak ada kasus yang cocok dalam pernyataan switch?
   menggunakan default untuk menentukan data agar tidak ada kesalahan.
4. Opsional (Optional):
    Apa itu opsional (optional) dalam Swift, dan mengapa digunakan?
   untuk nilai yang memiliki value ataupun nil, menghindari kesalahan runtime untuk variabel yang tidak memiliki nilai.
    Bagaimana Anda mendeklarasikan dan menggunakan variabel opsional?
   var variable: String?
    Apa perbedaan antara "unwrapping" opsional secara aman dengan "force unwrapping"?
   force unwrapping digunakan untuk membuka nilai yang beneran memiliki nilai sedangkan optional unwrapping digunakan untuk membuka nilai yang belum tentu memiliki nilai.
    Bagaimana Anda menangani nilai-nilai nil dalam opsional?
   conditional binding, menggunakan if-else untuk memeriksa jika variabel memiliki nilai dan jika tidak memiliki nilai akan diabaikan.
5. Operasi String:
    Bagaimana Anda menggabungkan (concatenate) dua string dalam Swift?
   bisa menggunakan ""+"", "\(..)", var += "".
    Bagaimana Anda menghitung panjang (count) sebuah string?
   var a = "Hello"
   result = a.count
    Apa itu interpolasi string, dan bagaimana cara penggunaannya?
   untuk menambahkan value variable string, "Halo, \(John)"
7. Error Handling (Penanganan Error):
    Apa itu "Error" dalam Swift, dan mengapa Anda memerlukan penanganan error?
   kesalahan pada code seperti akses ke value yang tidak ada. ERROR HANDLING
    Bagaimana Anda menggunakan pernyataan do, try, dan catch untuk menangani error?
   do {  //Untuk menempatkan code
    try performOperation() //Untuk mengeksekusi code
    print("No errors occurred.")
} catch { //Untuk menangani error dengan mencetak pesan.
    print("An unexpected error occurred.")
}
    Apa perbedaan antara try?, try!, dan try dalam Swift?
try untuk menjalankan code yang ingin diuji, try? untuk menjalankan code yang mungkin menghasilkan error dengan nil, try! digunakan untuk menguji code yang pasti berhasil.
