abstract class RequestServices {
  sendMechanicRequest({
    required String userLatLang,
    required String problemType,
    required String note,
    required String requestType,
  });

  sendMechanicHireNoti({
    required String hiredMechanic,
    required String userName,
  });
}
