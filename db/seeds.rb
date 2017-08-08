# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User: fname:string lname:string email:string username:string password:string img_src:string created_at:timestamp updated_at:timestamp
User.destroy_all
User.create([
    { fname:"Michael", lname:"Perez", email:"fresh@gmail.com", username:"FreshOceans", password:"pass123" },
    { fname:"Monique", lname:"Bolosan", email:"mbolo@gmail.com", username:"Olympia", password:"bolo123" },
    { fname:"Natasha", lname:"Perez", email:"nyu@gmail.com", username:"NYU", password:"lass123" },
    { fname:"Alexander", lname:"Chung", email:"alex@gmail.com", username:"alex", password:"pass123" },
    { fname:"Matt", lname:"Wojtkun", email:"matt@gmail.com", username:"matt", password:"pass123" },
    { fname:"Val", lname:"Choukhachian", email:"val@gmail.com", username:"valjan", password:"pass123" }
])

# Admin: fname:string lname:string email:string username:string password:string img_src:string created_at:timestamp updated_at:timestamp
Admin.destroy_all
Admin.create([
    { fname:"Michael", lname:"Nobre", email:"xFresh@gmail.com", username:"xFreshOceans", password:"pass123" },
    { fname:"Monique", lname:"Bolosan", email:"mbolo@gmail.com", username:"xOlympia", password:"pass123" }
])

# County: name:string created_at:timestamp updated_at:timestamp
County.destroy_all
County.create([
    { name:"Arlington" },
    { name:"Fairfax" },
    { name:"D.C." },
    { name:"Montgomery"},
    { name:"Alexandria"}
])

# Trail: csv_id:integer, name:string, length:float, surface:string, surface_rating:float traffic_rating:float, scenery_rating:float, overall_rating:float, created_at:timestamp updated_at:timestamp
# Trail.destroy_all
# Trail.create([
#     { csv_id:1, name:"The Mount Vernon Trail", length:18, surface:"Pavement", surface_rating:5, traffic_rating:4, scenery_rating:5, overall_rating:4.5  },
#     { csv_id:2, name:"The Great Washington Bicycle Loop Ride", length:30, surface:"Pavement", surface_rating:5, traffic_rating:5, scenery_rating:5, overall_rating:3.5  },
#     { csv_id:3, name:"Key Chain Tour", length:16, surface:"Pavement", surface_rating:3, traffic_rating:5, scenery_rating:4, overall_rating:4  },
#     { csv_id:4, name:"The Arlington Triangle", length:17, surface:"Pavement", surface_rating:5, traffic_rating:4, scenery_rating:5, overall_rating:4.75  },
#     { csv_id:5, name:"A Ride to the Falls", length:27, surface:"Unpaved", surface_rating:3, traffic_rating:1, scenery_rating:5, overall_rating:3.5  },
#     { csv_id:6, name:"Case Bridge Crossing", length:1, surface:"Pavement", surface_rating:2, traffic_rating:2, scenery_rating:2, overall_rating:2  }
# ])

# CountyTrail: county_id:integer, trail_id:integer, created_at:timestamp updated_at:timestamp
CountyTrail.destroy_all
CountyTrail.create([
    { county_id:1, trail_id:1 },
    { county_id:2, trail_id:3 },
    { county_id:3, trail_id:2 },
    { county_id:4, trail_id:4 }
])

# Report user_id:integer surface_rating:integer traffic_rating:integer scenery_rating:integer overall_rating:integer comment:text created_at:timestamp updated_at:timestamp
Report.destroy_all
Report.create([
    { user_id:2, surface_rating:5, traffic_rating:6, scenery_rating:5, overall_rating:5, comment:"Vestibulum tincidunt malesuada tellus." },
    { user_id:3, surface_rating:4, traffic_rating:5, scenery_rating:4, overall_rating:4, comment:"Morbi in dui quis est" },
    { user_id:3, surface_rating:4, traffic_rating:5, scenery_rating:6, overall_rating:3, comment:"Sed aliquet risus a tortor." },
    { user_id:4, surface_rating:7, traffic_rating:8, scenery_rating:9, overall_rating:5, comment:"Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos." },
    { user_id:2, surface_rating:5, traffic_rating:6, scenery_rating:6, overall_rating:2, comment:"In vel mi sit amet augue congue elementum." },
    { user_id:3, surface_rating:6, traffic_rating:6, scenery_rating:5, overall_rating:3, comment:"Sed cursus ante dapibus diam." },
    { user_id:4, surface_rating:8, traffic_rating:9, scenery_rating:5, overall_rating:4, comment:"Ut orci risus, accumsan porttitor, cursus quis, aliquet eget, justo." },
    { user_id:1, surface_rating:3, traffic_rating:4, scenery_rating:6, overall_rating:5, comment:"Integer id quam." },
    { user_id:2, surface_rating:1, traffic_rating:3, scenery_rating:2, overall_rating:4, comment:"Proin sodales libero eget ante. Nulla quam. Aenean laoreet. Vestibulum nisi lectus, commodo awe." },
    { user_id:5, surface_rating:3, traffic_rating:3, scenery_rating:2, overall_rating:4, comment:"The site is Gothane, a table-top 3,051ft (930m)-high mountain in the western state of Maharashtra, lashed by squally winds and ringed." },
    { user_id:5, surface_rating:5, traffic_rating:2, scenery_rating:4, overall_rating:3, comment:"TIn Malaysia, more than 50% of those surveyed said they used WhatsApp for news at least once a week." }
])

# TrailReport: trail_id:integer, report_id:integer, created_at:timestamp updated_at:timestamp
TrailReport.destroy_all
TrailReport.create([
    { trail_id:1, report_id:1 },
    { trail_id:2, report_id:2 },
    { trail_id:3, report_id:3 },
    { trail_id:4, report_id:4 },
    { trail_id:5, report_id:5 },
    { trail_id:4, report_id:8 },
    { trail_id:2, report_id:9 },
    { trail_id:2, report_id:10 },
    { trail_id:3, report_id:11 },
    { trail_id:1, report_id:12 }
])

#Tag: category_name:string
Tag.destroy_all
Tag.create([
    { category_name:"Scenic" },
    { category_name:"Busy" },
    { category_name:"Narrow Lanes" },
    { category_name:"Large Lanes" },
    { category_name:"Fun" },
    { category_name:"Intricate" },
    { category_name:"Windy" }
])

# TrailTag: trail_id:integer, tag_id:integer, created_at:timestamp updated_at:timestamp
TrailTag.destroy_all
TrailTag.create([
    { trail_id:1, tag_id:1 },
    { trail_id:2, tag_id:3 },
    { trail_id:3, tag_id:2 },
    { trail_id:4, tag_id:4 },
    { trail_id:5, tag_id:5 },
])
