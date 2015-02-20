# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


fields = "Medical / Health
Accounting / Finance / Insurance
Administrative / Clerical
Banking / Real Estate / Mortgage Professionals
Biotech / R&D / Science
Building Construction / Skilled Trades
Business / Strategic Management
Creative / Design
Customer Support / Client Care
Editorial / Writing
Education / Training
Engineering
Food Services / Hospitality
Human Resources
IT / Software Development
Installation / Maintenance / Repair
Legal
Logistics / Transportation
Manufacturing / Production / Operations
Marketing / Product
Other
Project / Program Management
Quality Assurance / Safety
Sales / Retail / Business Development
Security / Protective Services"

job_categories = fields.split("\n")

medicalCategory = nil
job_categories.each do |category|
  c = Category.create(name: category)
  if (category == "Medical / Health")
    medicalCategory = c
  end
end

questions = ["Why did you chose med school?", "How do you like your current field?"]

qtemp1 = Question.create(content: "Why med school?")
qtemp2 = Question.create(content: "How do you like your current field?")

Categoryquestion.create(question_id: qtemp1.id, category_id: medicalCategory.id)
Categoryquestion.create(question_id: qtemp2.id, category_id: medicalCategory.id)

u = User.create(firstname: "Rebecca", lastname: "Mark")
uq = Userquestion.create(user_id:u.id, question_id: qtemp2.id)
