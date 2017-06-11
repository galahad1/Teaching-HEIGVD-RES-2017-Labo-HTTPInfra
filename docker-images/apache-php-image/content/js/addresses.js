$(function() {
    console.log("Loading addresses");

    function loadAddresses() {
        $.getJSON("/api/addresses/", function(addresses) {
            console.log(addresses);
            var message = "No address";

            if (addresses.length > 0) {
                message = addresses[0].street + " "
                          + addresses[0].city + " "
                          + addresses[0].country;
            }
            $("#generatedAddresses").text(message);
        });
    }

    loadAddresses();
    setInterval(loadAddresses, 1000);
});