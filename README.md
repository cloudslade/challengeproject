# challengeproject
A project demonstrating basic iOS development skills

Overall design:
 I follwed a master-detail design layout using a table View to display the the list of information and a view controller to display additional data on the information contained within the cells.
I used MVC design patterns to make updating and working with the code much easier.
Core data was used to persisnt my one model object, a User.
It is possible to reload the list of users by pulling down on the tableview. This makes an async network call to fetch and initializer users from an endpoint.
When the user navigates to the detail screen a network call is made to fetch a thumbnail photo for that user (although currently not displaying properly).

I made the assumption that the json format would be consistent for both the photo enpoint and the user endpoint and created failable initializers to handle this format

I feel this app could use a cleaner detail screen that describes what each of the labels information is displaying. This would require more views and layout constraints. 
I would add a scroll view to the detail screen and fix the error of the imageView not updating after the network request to fetch the photo.
I would also make some custom 'UserCells' and display their photo in a small thumbnail in the tableview cell.