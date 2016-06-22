####################################################
#                Live Data                         #
####################################################

# Short Courses
course = Course.create(course_type: "Workshop", name: "Coding Kickstarter", tagline: "This FREE introduction to coding workshop gives you a sneak peek into computer programmer life (at no cost!) in an engaging, hands-on environment. Learn to build a live application in only two hours, and conjure big ideas of what you could accomplish in a lifetime... or one of our other courses!", description: "TODO", price: 0.0)
Course.create(course_type: "Workshop", name: "12 Week Course", tagline: "The web app builder course is our part-time solution for entrepreneurs. Learn to build a viable web application in only 12 weeks... while keeping your day job. Become a confident web application developer with full-stack skills, able to build anything you want using Ruby on Rails and more.", description: "TODO", price: 0.0)
Course.create(course_type: "Workshop", name: "Coding For Beginners", tagline: "Whether you want to upskill or start fresh, our beginners course will prepare you to build, test, and deploy new apps. Learn the in-demand skills you need to build revolutionary technology. Dive into the fundamentals of coding with Ruby on Rails, HTML, CSS, and Bootstrap.", description: "TODO", price: 0.0)
Course.create(course_type: "Workshop", name: "Web Desgn For Beginners", tagline: "Every business either has a website - or needs a website. Knowing the basics of designing for the web helps you understand what is possible and can save you money. Perhaps you want to create a stylish web presence for yourself to showcase your achievements or a portfolio of your work. Sure, there are a lot of web applications out there that will help you do this but if you want to individualise it with your own style, you need to know HTML and CSS. HTML and CSS are the building blocks of the web and a great entry point into learning more about creating technology.", description: "TODO", price: 0.0)
Course.create(course_type: "Workshop", name: "Javscript", tagline: "TODO", description: "TODO", price: 0.0)
Course.create(course_type: "Workshop", name: "High School Coder", tagline: "Knowing how to code can help you understand technology better, give you more options when choosing your career, and could even help you earn money before you leave school. Be a part of the future. Learn to code.", description: "TODO", price: 0.0)
Course.create(course_type: "Workshop", name: "Primary School Coder", tagline: "TODO", description: "TODO", price: 0.0)

# Corporate courses
Course.create(course_type: "Corporate", name: "Demystify Tech", tagline: "TODO", description: "TODO", price: 0.0)
Course.create(course_type: "Corporate", name: "Transformer", tagline: "This deeper dive into coding is delivered over 1 month in 4 X 3 hour sessions. An actual business problem is identified and participants undertake a mini hackathon to create a solution and build a web application to resolve the issue. Face the challenge like a startup and use agile and lean startup practices to create a working product that your organisation can communicate across the company and beyond.", description: "TODO", price: 0.0)
Course.create(course_type: "Corporate", name: "Introduction To Coding", tagline: "In one day participants are exposed to programming fundamentals and the possibilities of applying coding concepts to transform business processes. Get hands on and build a web application to stretch your mind with new approaches to problem solving and critical thinking.", description: "TODO", price: 0.0)

# Schools courses
Course.create(course_type: "Schools", name: "Coding And The Digital Curriculum", tagline: "This 1 day workshop helps participants to understand the software development process and recognise how emerging technology can assist in solving problems. We explore the new Digital Curriculum and how coding can be used to develop strategies to enhance cross curriculum activities.", description: "TODO", price: 0.0)
Course.create(course_type: "Schools", name: "Student Deeper Dive", tagline: "This intensive program is delivered over a term in 2 hour sessions. An actual school or community problem is identified and you and your students undertake a mini hackathon to create a solution and build a web application to resolve the issue. Face the challenge like a technology startup and use design thinking and coding to create a working product that your school can promote across the faculty and beyond.", description: "TODO", price: 0.0)
Course.create(course_type: "Schools", name: "Hands On Coding", tagline: "In this 1 day workshop participants are exposed to programming fundamentals and the possibilities of applying coding concepts to transform school challenges. Get hands on and build a web application to stretch your mind with new approaches to problem solving and critical thinking.", description: "TODO", price: 0.0)


####################################################
#                Test Data                         #
####################################################

Intake.create(course: course, start: DateTime.now, finish: DateTime.now.tomorrow, location: "Coder Factory HQ", class_size: 10)
Intake.create(course: course, start: DateTime.now, finish: DateTime.now.tomorrow, location: "Coder Factory HQ", class_size: 10)
Intake.create(course: course, start: DateTime.now, finish: DateTime.now.tomorrow, location: "Coder Factory HQ", class_size: 10)
Intake.create(course: course, start: DateTime.now, finish: DateTime.now.tomorrow, location: "Coder Factory HQ", class_size: 10)
Intake.create(course: course, start: DateTime.now, finish: DateTime.now.tomorrow, location: "Coder Factory HQ", class_size: 10)
Intake.create(course: course, start: DateTime.now, finish: DateTime.now.tomorrow, location: "Coder Factory HQ", class_size: 10)

PromoCode.create(code: "test", percent: 10, note: "A test code.")
