$(document).ready(function () {
  $("#supplied").click(function () {
    $("supplied").css("display", "inline");
  });

  $("#del").click(function () {
    $("del").css("display", "inline");
  });

  $("#expan").click(function () {
    $("expan").css("display", "inline");
  });

  $("#hide").click(function () {
    $("supplied, del, expan").hide();
  });
});
