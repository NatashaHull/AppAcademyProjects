Rails Lite
==========
#Files
* [Server](https://github.com/NatashaHull/AppAcademyProjects/blob/master/Week5/W5D3/rails_lite-skeleton/test/my_first_server.rb)
* [Controller Base](https://github.com/NatashaHull/AppAcademyProjects/blob/master/Week5/W5D3/rails_lite-skeleton/lib/rails_lite/controller_base.rb) - This recreates many of the actions present in Rails's ActionController::Base, namely `render` and `redirect_to`.
* [Params](https://github.com/NatashaHull/AppAcademyProjects/blob/master/Week5/W5D3/rails_lite-skeleton/lib/rails_lite/params.rb) - This extracts a params hash from the server request.
* [Session](https://github.com/NatashaHull/AppAcademyProjects/blob/master/Week5/W5D3/rails_lite-skeleton/lib/rails_lite/session.rb) - This module adds cookies to the server's response to keep track of session information set by the controller.
* [Router](https://github.com/NatashaHull/AppAcademyProjects/blob/master/Week5/W5D3/rails_lite-skeleton/lib/rails_lite/router.rb) - This recreates Rails's Application.routes
* [Url Helper](https://github.com/NatashaHull/AppAcademyProjects/blob/master/Week5/W5D3/rails_lite-skeleton/lib/rails_lite/url_helper.rb) - This creates url helper methods for simple urls (url's that do not include any parameters) when they are defined in the router.

#Notes
This project came back to mind the last time I experimented with/used `node.js`. Part of the reason for that is simply because I have to basically do all of this again with node, with a few exceptions (such as finding parameters).
