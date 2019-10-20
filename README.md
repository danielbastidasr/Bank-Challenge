# MVVM Architecture App
A client would like a directory app to allow staff to:
 - See all of their colleagues contact details
 - See which rooms in the office are currently occupied.

# 🔌 Data Source

The API that provides the necessary data is located at https://5cc736f4ae1431001472e333.mockapi.io/api/v1 and is RESTful with 2 resources:

- people 
- rooms

Both support `GET` requests to list the data and also to directly access individual records (the API is read only).

# 📖 Development Story

The following story around how the app will be used should inform how you approach development/code structure:

The client aim to use their branding in all of their internal services. They currently use a main brand color 
`#C40202` however they are in the early stages of a rebrand that may lead this to change in the near future.

All employees will have access to the app and will expect the ability to quickly pull up and use the contact details of any of their colleagues. Employees use iOS devices across the full range, so your design must work across iPhones and iPads. Several of our employees use the accessibility features of iOS, so your app **should** be accessibile. 

If the trial of the Directory app proves successful with the staff, We may look to expand the app so that it will also allow users to access and administer more data, so ensure that the app can be easily expanded both in terms of codebase and UX.  The code from this app could be used in other applications so modularity is **important**. If the app expands in scope, it will be more rigorously tested by our QA resource and will therefore **need** to support a test environment as well as a live environment. 

We cannot guarantee that the same developer(s) will always be working on this app throughout it's lifecycle, so it is important that other developers will be able to onboard themselves onto the codebase with ease.

# 🏁 Finished! 
