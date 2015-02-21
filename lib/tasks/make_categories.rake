task :make_categories do
  
  fields = "
  General
  Medical / Health
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

  job_categories.each do |category|
    Category.create(name: category)
  end
end
