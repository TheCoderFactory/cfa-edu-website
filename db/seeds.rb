# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Course.create(course_type: "Workshop", name: "Coding Kickstarter (FREE)", description: "Two hour free workshop, Sundays, 2pm - 4pm
              Learn how great Ruby on Rails is and why you should pick this cool language to get started on your coding journey.
              Install Ruby on Rails on your own laptop and create your first web application.
              One of the main barriers to getting started with Rails is setting up your laptop. This workshop will help you through this stage and allow you to start your coding journey with less pain.
              You'll also build your first, simple web application so you can start to see how cool Ruby on Rails is - and we want to inspire you to continue to learn to code.
              What will I learn?
              The developer's toolkit.
              Set up your 'development environment' and learn about open source tools.
              Building your first web app:
              Create! Learn! Build!
              Learning resources and options:
              Find out other great ways to continue your 'learn to code' journey.
              Classroom options:
              Hear about the other classroom learning options: workshops, part time courses and the Fast Track full time program.", tagline: "Coding is fun - and anyone can do it. Come along to this workshop and let us help you get started.", price: 0.00)
course = Course.create(course_type: "Workshop", name: "Coding For Beginners", description: "The technology revolution
              We are surrounded by technology and use it every day. And guess what? It's just beginning.
              The tech revolution is just getting warmed up. There are so many ways that technology has yet to improve our lives. Whether it's a life saving gadget or a phone app that makes us laugh.
              The future is coming fast
              You can either stand by and watch it happen, or be a part of it and have the power to create a great life for yourself and those around you.
              Learning to code is not rocket science. Anyone can do it. And it's FUN! Let your creativity flow and build cool technology that makes a difference in the world. Be a part of the future. Learn to code.
              WHAT CAN I EXPECT?
              As a class, we will set up your development environment as this is key to creating, testing and deploying new apps. We will teach you the skills to create new apps, and ways to speed up deployment using scaffolding.
              This course will give you an understanding of Ruby gems that enable greater functionality for your app, and give you the skills needed to implement popular gems into your apps.
              The course is a fun and interactive way of learning the fundamentals behind coding in Ruby on Rails", tagline: "Learning to code is not rocket science. Anyone can do it. And its FUN!", price: 300.00)
Course.create(course_type: "Workshop", name: "Web App Builder", description: "Learn Fast
              In just 12 weeks (six class hours per week), you will become a confident web application developer, able to build anything you want.
              Full stack development
              Ruby on Rails gives you full stack skills - front end, backend, databases, application design and deployment.
              Build your own idea
              You will have the opportunity to apply your new skills by building your own app idea in the final 4 weeks of the course.
              Classes are fun and practical!
              With a focus on hands-on coding in every class, you will have fun while you learn. We love our amazing students at Coder Factory, they are always smart and inspiring people to know.
              Tried learning online?
              If you've tried learning online but keep hitting road blocks (or boredom), the Web App Developer PT course is the best way to learn coding. Meet other aspiring startup entrepreneurs who have taken action and realised that learning to code is going to change their future.", tagline: "Learn web app development in 12 weeks, while keeping your day job.", price: 2475.00)

Intake.create(course: course, start: DateTime.now, finish: DateTime.now.tomorrow, location: "Coder Factory HQ", class_size: 0)
Intake.create(course: course, start: DateTime.now, finish: DateTime.now.tomorrow, location: "Coder Factory HQ", class_size: 0)
Intake.create(course: course, start: DateTime.now, finish: DateTime.now.tomorrow, location: "Coder Factory HQ", class_size: 0)
Intake.create(course: course, start: DateTime.now, finish: DateTime.now.tomorrow, location: "Coder Factory HQ", class_size: 0)
Intake.create(course: course, start: DateTime.now, finish: DateTime.now.tomorrow, location: "Coder Factory HQ", class_size: 0)
Intake.create(course: course, start: DateTime.now, finish: DateTime.now.tomorrow, location: "Coder Factory HQ", class_size: 10)

PromoCode.create(code: "test", percent: 10, note: "A test code.")
