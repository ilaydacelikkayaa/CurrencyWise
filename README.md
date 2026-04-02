#  CurrencyWise

**CurrencyWise**, Swift ile geliştirilmiş; şık, modern ve yüksek performanslı bir döviz dönüştürücü uygulamasıdır. Minimalist kullanıcı arayüzü ve güçlü mimarisiyle, kullanıcılara gerçek zamanlı ve kesintisiz bir döviz çeviri deneyimi sunar.


##  Öne Çıkan Özellikler

* **Gerçek Zamanlı Dönüşüm:** Küresel para birimleri için anlık döviz kuru güncellemeleri.
* **Özel Numerik Klavye:** Daha hızlı ve sezgisel finansal hesaplamalar için projeye özel tasarlanmış giriş arayüzü.
* **Modern Karanlık Mod (Dark UI):** Apple'ın "Human Interface Guidelines" prensiplerine uygun, göz yormayan, şık arayüz.
* **Güçlü Ağ Katmanı (Networking):** API isteklerini ve JSON verilerini işleyen profesyonel seviyede network katmanı.

## Teknik Altyapı ve Mimari

Bu proje, sürdürülebilirlik ve temiz kod (clean code) prensipleri odak alınarak inşa edilmiştir:

* **Dil:** Swift 5.0+
* **Framework:** UIKit
* **Mimari:** Sorumlulukların net bir şekilde ayrılması için **MVVM** (Model-View-ViewModel).
* **Tasarım Kalıbı:** Veri kaynaklarını soyutlamak ve iş mantığını merkezileştirmek için **Repository Pattern**.
* **Proje Yapısı:** Bakımı kolaylaştırmak adına `Modules`, `Network`, `Models` ve `Utilities` gibi modüler gruplara ayrılmıştır.

##  Proje Yapısı

Kod tabanı şu şekilde organize edilmiştir:

- **Modules:** Özellik bazlı ViewControllers ve ViewModels (Converter, Welcome).
- **Network:** API iletişimi ve döviz kuru (ExchangeRate) servisleri.
- **Models:** Veri yapıları ve uygulama durumları (states).
- **Globals:** `AppColors` ve `Constants` (Sabitler) için merkezi yönetim.
- **Utilities:** Yerel türleri geliştiren yardımcı araçlar (Örn: `Double+Formatting`).

---

## Kurulum ve Çalıştırma

1.  **Depoyu klonlayın:**
    ```bash
    git clone [https://github.com/ilaydacelikkaya/CurrencyWise.git](https://github.com/ilaydacelikkaya/CurrencyWise.git)
    ```
2.  **`CurrencyWise.xcodeproj`** (veya güncellediğiniz proje dosyası) dosyasını Xcode ile açın.
3.  Bir iOS Simülatörü seçin (iOS 15.0+ önerilir).
4.  Derlemek ve çalıştırmak için **Command + R** tuşlarına basın.


*Developed with  by [İlayda Çelikkaya](https://github.com/ilaydacelikkaya)*
