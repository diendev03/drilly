# ---Date: 20 Sep, 2024---

# -Compatible with iOS 18-

# **Updated Files**

screens/
-[forgot_password.dart](lib/screens/login/forgot_password.dart)
-[list_widget.dart](lib/screens/salon/gallery/list_widget.dart)
-[qr_scan_screen.dart](lib/screens/qrScan/qr_scan_screen.dart)
-[setting_screen.dart](lib/screens/setting/setting_screen.dart)

-[pubspec.yaml](pubspec.yaml)

iOS/
-[Podfile](ios/Podfile)

# **Added Files**

None

# **Deleted Files**

-[web_view_screen.dart](lib/screens/web/web_view_screen.dart)

## Note: Don't forget to change your credentials after updating file.

----------------------------------------------------------------------------------------------------

# ---Date: 28 Aug, 2024---

# -Update Charts Library-

# **Updated Files**

screens/
-[earning_screen.dart](lib/screens/earning/earning_screen.dart)

pubspec/
-[pubspec.yaml](pubspec.yaml)

# **Added Files**

None

## Note: Don't forget to change your credentials after updating file.

----------------------------------------------------------------------------------------------------

# ---Date: 22 June, 2024---

# -Pay After Service Option added-

# -Serve At My Location address added-

# -Choose Barber Options added-

# **Added Files**

images
-[ic_menu.png](images)
-[ic_navigator2.png](images)
-[ic_user.png](images)

bloc
-[add_staff_bloc.dart](lib/bloc/addstaff)
-[add_staff_event.dart](lib/bloc/addstaff)
-[add_staff_state.dart](lib/bloc/addstaff)
-[manage_staff_bloc.dart](lib/bloc/managestaff)
-[manage_staff_event.dart](lib/bloc/managestaff)
-[manage_staff_state.dart](lib/bloc/managestaff)
-[staff_order_history_bloc.dart](lib/bloc/orderhistory)
-[staff_order_history_state.dart](lib/bloc/orderhistory)
-[staff_order_history_event.dart](lib/bloc/orderhistory)

model
-[staff.dart](lib/model/staff)
-[address.dart](lib/model/address/address.dart)

screens/
-[add_staff_screen.dart](lib/screens/addStaff)
-[manage_staff_screen.dart](lib/screens/staff)
-[salon_staff_page.dart](lib/screens/salon)
-[staff_order_history_screen.dart](lib/screens/stafforderhistory)

# **Updated Files**

l10n
-[intl_ar.arb](lib/l10n/intl_ar.arb)
-[intl_da.arb](lib/l10n/intl_da.arb)
-[intl_de.arb](lib/l10n/intl_de.arb)
-[intl_el.arb](lib/l10n/intl_el.arb)
-[intl_en.arb](lib/l10n/intl_en.arb)
-[intl_es.arb](lib/l10n/intl_es.arb)
-[intl_fr.arb](lib/l10n/intl_fr.arb)
-[intl_hi.arb](lib/l10n/intl_hi.arb)
-[intl_id.arb](lib/l10n/intl_id.arb)
-[intl_it.arb](lib/l10n/intl_it.arb)
-[intl_ja.arb](lib/l10n/intl_ja.arb)
-[intl_ko.arb](lib/l10n/intl_ko.arb)
-[intl_nb.arb](lib/l10n/intl_nb.arb)
-[intl_nl.arb](lib/l10n/intl_nl.arb)
-[intl_pl.arb](lib/l10n/intl_pl.arb)
-[intl_pt.arb](lib/l10n/intl_pt.arb)
-[intl_ru.arb](lib/l10n/intl_ru.arb)
-[intl_th.arb](lib/l10n/intl_th.arb)
-[intl_tr.arb](lib/l10n/intl_tr.arb)
-[intl_vi.arb](lib/l10n/intl_vi.arb)
-[intl_zh.arb](lib/l10n/intl_zh.arb)

model
-[request_details.dart](lib/model/request/request_details.dart)
-[salon.dart](lib/model/user/salon.dart)

screens/
-[edit_salon_categories_widget.dart](lib/screens/editSalon/edit_salon_categories_widget.dart)
-[email_login_screen.dart](lib/screens/login/login_screen.dart)
-[item_manage_service.dart](lib/screens/manageServices/item_manage_service.dart)
-[manage_services.dart](lib/screens/manageServices/manage_services.dart)
-[registration_screen.dart](lib/screens/registration/registration_screen.dart)
-[setting_screen.dart](lib/screens/setting/setting_screen.dart)
-[booking_history_screen.dart](lib/screens/bookinghistory)
-[bookings_screen.dart](lib/screens/booking/bookings_screen.dart)
-[complete_booking_sheet.dart](lib/screens/booking/widget/complete_booking_sheet.dart)
-[history_widget.dart](lib/screens/bookinghistory/history_widget.dart)
-[manage_award.dart](lib/screens/manageAward/manage_award.dart)
-[manage_services.dart](lib/screens/manageServices/manage_services.dart)
-[manage_staff_screen.dart](lib/screens/staff/manage_staff_screen.dart)
-[request_detail_screen.dart](lib/screens/requestDetails/request_detail_screen.dart)
-[salon_details_page.dart](lib/screens/salon/salon_details_page.dart)
-[salon_details_screen.dart](lib/screens/salon/salon_details_screen.dart)
-[salon_gallery_page.dart](lib/screens/salon/salon_gallery_page.dart)
-[select_location_screen.dart](lib/screens/map/select_location_screen.dart)
-[setting_screen.dart](lib/screens/setting/setting_screen.dart)
-[wallet_screen.dart](lib/screens/wallet/wallet_screen.dart)

service
-[api_service.dart](lib/service/api_service.dart)

utils
-[custom_widget.dart](lib/utils/custom/custom_widget.dart)
-[const_res.dart](lib/utils/const_res.dart)
-[app_res.dart](lib/utils/app_res.dart)
-[asset_res.dart](lib/utils/asset_res.dart)

## Note: Don't forget to change your credentials after updating file.

----------------------------------------------------------------------------------------------------
---Date: 29 May, 2024---

# -Update all dependencies in pubspec.yaml & Gradle File.-

# -Bug Fixes & Resolved deprecated code.-

# **Deleted Files**

#flutter
-[qr_scanner.dart](lib/screens/home)

# **Updated Files**

#android
-[AndroidManifest.xml](./android/app/src/main/AndroidManifest.xml)
-[build.gradle](./android/app/build.gradle)
-[build.gradle](./android/build.gradle)
-[gradle.properties](./android/gradle.properties)
-[gradle-wrapper.properties](./android/gradle/wrapper/gradle-wrapper.properties)
-[settings.gradle](./android/settings.gradle)
#flutter
#/lib/screens
-[chat_screen.dart](./lib/screens/chat/chat_screen.dart)
-[earning_screen.dart](./lib/screens/earning/earning_screen.dart)
-[edit_salon_screen.dart](./lib/screens/editSalon/edit_salon_screen.dart)
-[gallery_screen.dart](./lib/screens/gallery/gallery_screen.dart)
-[qr_scan_screen.dart](./lib/screens/qrScan/qr_scan_screen.dart)
-[salon_details_page.dart](./lib/screens/salon/salon_details_page.dart)
-[select_location_screen.dart](./lib/screens/map/select_location_screen.dart)
-[signup_salon_address.dart](./lib/screens/registration/signup_salon_address.dart)
-[video_preview_screen.dart](./lib/screens/preview/video_preview_screen.dart)
-[wallet_screen.dart](./lib/screens/wallet/wallet_screen.dart)
#/lib/model
-[faqs.dart](./lib/model/faq/faqs.dart)
#/lib/utils
-[custom_widget.dart](./lib/utils/custom/custom_widget.dart)
-[style_res.dart](./lib/utils/style_res.dart)
#/lib/bloc
-[request_details_bloc.dart](./lib/bloc/requestdetails/request_details_bloc.dart)
#/lib/
-[main.dart](./lib/main.dart)

-[pubspec.yaml](pubspec.yaml)

## Note: Don't forget to change your credentials after updating file.

----------------------------------------------------------------------------------------------------

# ---Date: 15 May, 2024---

## Update Gradle File & Resolve Conflict of const_res.dart.

# **Updated Files**

- [/lib/utils/const_res.dart](./lib/utils/const_res.dart)
- [/android/app/build.gradle](./android/app/build.gradle)
- [/android/build.gradle](./android/build.gradle)
- [/android/settings.gradle](./android/settings.gradle)