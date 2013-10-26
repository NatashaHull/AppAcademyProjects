$(document).ready(function() {
  // ... the AJAX request is successful
  var updateFriendPage = function( resp ) {
    $('.friend-buttons > span').toggleClass("cant-press");
    alert("You are now friends!");
  };

  var updateUnfriendPage = function( resp ) {
    $('.friend-buttons > span').toggleClass("cant-press");
    alert("You are now enemies!");
    $(".friend").attr("disabled", false);
    $(".unfriend").attr("disabled", false);
  };

  // ... the AJAX request fails
  var printError = function( req, status, err ) {
    alert( 'something went wrong', status, err );
    $(".friend").attr("disabled", false);
    $(".unfriend").attr("disabled", false);
  };

  $('.friend').on('click', function(e) {
    var button = $(e.currentTarget)
    button.attr("disabled", true);
    var user_id = parseInt(button.attr('data-friendee-id'))
    $.ajax({
      type: "POST",
      url: "http://localhost:3000/users/" + user_id + "/friendships.json",
      data: {
        friendship: {
          friendee_id: user_id
        }
      },
      success: updateFriendPage,
      error: printError
    });
  });

  $('.unfriend').on('click', function(e) {
    var button = $(e.currentTarget)
    button.attr("disabled", true);
    var user_id = parseInt(button.attr('data-friendee-id'))
    $.ajax({
      type: "DELETE",
      url: "http://localhost:3000/users/" + user_id + "/friendships/1.json",
      success: updateUnfriendPage,
      error: printError
    });
  });

  $('#secret').on("submit", function(event) {
    event.preventDefault();
    var secretFormData = $(this).serialize();

    $.ajax({
      url: '/secrets',
      type: "POST",
      data: secretFormData,
      success: function() {
        //Update user secrets
        alert("You just added a new secret!")
        $('#secret > input').val("");
      }
    });
  });

  var addSecretTagSelect = function() {
    var templateCode = $('#tags_template').html();
    var templateFn = _.template(templateCode);
    var renderedContent = templateFn(
      JSON.parse($("#bootstrap_tags").html())
    );
    $("#secret-tag-selects").append(renderedContent + "</br>");
  }

  $(".add-more-tags").on("click", function() {
    addSecretTagSelect();
  });

  addSecretTagSelect();
});