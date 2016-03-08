# build category list
categories = [
  "Automotive",
  "Beauty and Wellness",
  "Beauty Shots",
  "Comedy",
  "Corporate",
  "Education",
  "Environmental",
  "Financial",
  "Food",
  "Furniture",
  "Government",
  "Health Care",
  "Insurance",
  "Interviews",
  "Legal",
  "Manufacturing",
  "Non-Profit",
  "Pets",
  "Real Estate",
  "Retail",
  "Retirement Community",
  "Service Industry",
  "Slice of Life",
  "Sports",
  "Technology",
  "White Board",
]

categories_lst = [];
categories.each {|cat| categories_lst << "Categories/"+cat}

# build playlist list
playlists = [
  "Christine",
  "Dan",
  "Erik",
  "HREDA",
  "iFly",
  "Jeff",
  "Katelyn",
  "Kim",
  "Lana",
  "Maria",
  "Matthew",
  "Mayor Folder",
  "Monarch Bank",
  "OC New Talent Meeting",
  "Robin Russ",
  "Rock Body",
  "Steve",
  "William",
]

playlists_lst = [];
playlists.each {|pla| categories_lst << "Playlist/"+pla}

# build location options
locations = [
  "3D Animation",
  "Archive",
  "Categories"
] + categories_lst + [
  "Latest and Greatest",
  "Motion Graphics",
  "NEW WORK",
  "Playlist"
  ] + playlists_lst + [
  "SC Originals",
  "Sizzle Reels",
  "Sizzle Reels/Categories",
  "Staff Reels",
  "Telly Winners",
  "Telly Winners/2015",
  "Telly Winners/2014"
]
