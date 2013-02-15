
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Admin Users
User.create :name => "mahesh",    :group_id => Group.find_by_name('admin').id, :ro => false
User.create :name => "jcramer",   :group_id => Group.find_by_name('admin').id, :ro => false
User.create :name => "kwrigh59", :group_id => Group.find_by_name('admin').id, :ro => false
User.create :name => "myoungman", :group_id => Group.find_by_name('admin').id, :ro => false

# Task Force
User.create :name => "appleton",  :group_id => Group.find_by_name('admin').id, :ro => true
User.create :name => "amclaugh",  :group_id => Group.find_by_name('admin').id, :ro => true
User.create :name => "croberts",  :group_id => Group.find_by_name('admin').id, :ro => true
User.create :name => "mwalsh8",   :group_id => Group.find_by_name('admin').id, :ro => true
User.create :name => "yvisser",   :group_id => Group.find_by_name('admin').id, :ro => true
User.create :name => "erdol",     :group_id => Group.find_by_name('admin').id, :ro => true

# Library
User.create :name => "miller",     :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('UL').id, :ro => false
User.create :name => "parish",     :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('UL').id, :ro => false

# Engineering
    
User.create :name => "ilyas",     :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('EG').id, :ro => false
 
User.create :name => "bfurht",  :group_id => Group.find_by_name('chair').id, :school_id => School.find_by_name('EG').id, 
            :department_id => Department.find_by_name('Computer & Electrical Eng & Comp Science').id, :ro => false
            
User.create :name => "pscarlat",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('EG').id, :department_id => Department.find_by_name('Civil, Environmental & Geomatics Engineering').id, :ro => false

User.create :name => "jhashemi",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('EG').id, :department_id => Department.find_by_name('Ocean & Mechanical Engineering').id, :ro => false

# Science
User.create :name => "perryg",    :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('SC').id, :ro => false

# Nursing
User.create :name => "msmit230",  :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('NU').id, :ro => false

 
# Business
User.create :name => "mrhorer",     :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('BA').id, :ro => false
User.create :name => "ejaffe",     :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('BA').id, :ro => false
User.create :name => "sbhatt",     :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('BA').id, :ro => false
User.create :name => "coates",    :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('BA').id, :ro => false
 
 
# College of Design and Social Inquiry
User.create :name => "rcarter",    :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('UP').id, :ro => false
User.create :name => "fcory",    :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('UP').id, :ro => false
User.create :name => "clinton",    :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('UP').id, :ro => false

User.create :name => "dhardy",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Architecture').id, :ro => false
User.create :name => "thai",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Criminology & Criminal Justice').id, :ro => false
User.create :name => "mhawkins",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Social Work').id, :ro => false
User.create :name => "jvos",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Urban & Regional Planning').id, :ro => false

 
# College of Arts and Letters

User.create :name => "coltman",     :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('AL').id, :ro => false

User.create :name => "rlautar",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Music').id, :ro => false

User.create :name => "dkopani",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Theatre & Dance').id, :ro => false

User.create :name => "ljohnson",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Visual Arts & Arts History').id, :ro => false

User.create :name => "nmarin",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Communication & Multimedia Studies').id, :ro => false

User.create :name => "mharris",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Anthropology').id, :ro => false

User.create :name => "dhardy",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Architecture').id, :ro => false

User.create :name => "afurman",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('English').id, :ro => false
 
User.create :name => "kollande",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('History').id, :ro => false
 
User.create :name => "horswell",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Lang, Linguistics & Comp Lit').id, :ro => false
 
User.create :name => "lenz",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Political Science ').id, :ro => false
 
User.create :name => "afurman",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('English').id, :ro => false
 
User.create :name => "araghi",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Sociology').id, :ro => false
 
User.create :name => "peralta",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Lang, Linguistics & Comp Lit').id, :ro => false
 
User.create :name => "efreedman",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('UP').id, :department_id => Department.find_by_name('Communication & Multimedia Studies').id, :ro => false


# Honors College
User.create :name => "sogden",  :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('HC').id, :ro => false
User.create :name => "jbuller", :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('HC').id, :ro => false

# College of Medicine
User.create :name => "armstron",  :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('BI').id, :ro => false
User.create :name => "dsalerno",  :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('BI').id, :ro => false

# College of Education
User.create :name => "bristor",  :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('ED').id, :ro => false
User.create :name => "torok",  :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('ED').id, :ro => false
User.create :name => "kdemeo",  :group_id => Group.find_by_name('dean').id, :school_id => School.find_by_name('ED').id, :ro => false

User.create :name => "ggeorge",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('ED').id, :department_id => Department.find_by_name('Exceptional Student Education').id, :ro => false
 
User.create :name => "mbrady",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('ED').id, :department_id => Department.find_by_name('Exceptional Student Education').id, :ro => false
 
User.create :name => "sgraves",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('ED').id, :department_id => Department.find_by_name('Exercise Science & Health Promotion').id, :ro => false
 
User.create :name => "ijohnso9",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('ED').id, :department_id => Department.find_by_name('Counselor Education').id, :ro => false
 
User.create :name => "jmclau17",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('ED').id, :department_id => Department.find_by_name('Curriculum, Culture & Educ Inquiry').id, :ro => false
 
User.create :name => "bridener",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('ED').id, :department_id => Department.find_by_name('Teaching and Learning').id, :ro => false

User.create :name => "shockley",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('ED').id, :department_id => Department.find_by_name('Ed Leadership & Research Methodology  ').id, :ro => false
 
User.create :name => "wener",  :group_id => Group.find_by_name('chair').id, 
            :school_id => School.find_by_name('ED').id, :department_id => Department.find_by_name('Communication Science & Disorders').id, :ro => false                         

#    User.destroy_all


['BU', 'MD', 'CS', 'HU', 'UN', 'AH', '99', 'LA', 'SS', 'MS'].each do |school_name|
  school = School.find_by_name(school_name)
  if (!school.nil?)
    school.enabled = false
    school.save
  end
end



# NAME|DESCRIPTION
# rake csv_model_import[/Users/mahesh/Downloads/xitracs/XITRACS_SCHOOLS.txt,School]  >> /tmp/import.log
# NAME|DESCRIPTION|SCHOOL_ID
# rake csv_model_import[/Users/mahesh/Downloads/xitracs/XITRACS_DEPARTMENTS.txt,Department] >> /tmp/import.log

# NAME|LEVEL
# rake csv_model_import[/Users/mahesh/Downloads/xitracs/XITRACS_QUALIFICATIONS_TYPE.txt,Qualification] >> /tmp/import.log
# QUALIFICATION_ID|NAME
# rake csv_model_import[/Users/mahesh/Downloads/xitracs/XITRACS_QUALIFICATIONS_AWARD.txt,Qualificationaward] >> /tmp/import.log

#ZNUMBER|EMAIL|FIRST_NAME|MIDDLE_NAME|LAST_NAME|TITLE_ID|DEPARTMENT_ID|RANK_ID|EMPLOYMENTSTATUS_ID|TENURESTATUS_ID|QUALIFICATION_ID|CV_ONFILE
# rake csv_model_import[/Users/mahesh/Downloads/xitracs/XITRACS_FACULTY_MEMBERS.txt,Faculty] >> /tmp/import.log

#NAME|TITLE|DESCRIPTION|DEPARTMENT_ID|LEVEL_DESCRIPTION|CREDIT|RULES|CIP_CODES
# rake csv_model_import[/Users/mahesh/Downloads/xitracs/XITRACS_COURSES.txt,Course] >> /tmp/import.log
#COURSE_ID|SEMESTER|NAME|TITLE|DESCRIPTION
# rake csv_model_import[/Users/mahesh/Downloads/xitracs/XITRACS_COURSE_SECTIONS.txt,Section] >> /tmp/import.log
#SECTION_ID|FACULTY_ID|EMAIL|SECTION_ROLE
# rake csv_model_import[/Users/mahesh/Downloads/xitracs/XITRACS_COURSE_SECTION_ENROLLMENTS.txt,Sectionenrollment]  >> /tmp/import.log

#FACULTY_ID|EMAIL|QUALIFICATIONAWARD_ID|QUALIFICATION_NAME|QUALIFICATION_INSTITUTION|QUALIFICATION_FIELD|QUALIFICATION_YEAR|TRANSCRIPT_ON_FILE|CIP_CODES
# rake csv_model_import[/Users/mahesh/Downloads/xitracs/XITRACS_FACULTY_CREDENTIALS.txt,Facultycredential] >> /tmp/import.log

#FACULTY_ID|EMAIL|QUALIFICATIONAWARD_ID|QUALIFICATION_NAME|QUALIFICATION_INSTITUTION|QUALIFICATION_YEAR|SECTION_ID
# rake csv_model_import[/Users/mahesh/Downloads/xitracs/XITRACS_COURSE_SECTION_CREDENTIALS.txt,Sectioncredential] >> /tmp/import.log


