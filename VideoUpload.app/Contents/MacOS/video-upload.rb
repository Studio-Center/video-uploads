require "net/ftp"

# available servers
servers = [
  "WDMyCloud161.sc.studiocenter.com",
  "WDMyCloud240.sc.studiocenter.com",
  "WDMyCloudRVA.sc.studiocenter.com",
  "WDMyCloudDC.sc.studiocenter.com",
]

# default share credentials
user = "file"
password = "TransferNow"
# default ftp creds
# u: file
# p: TransferNow

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

Shoes.app(title: "Studio Center Video Uploader", width: 900, height: 1000, resizable: false) do
  $stdout.sync = true
  flow do
    locsHalf = locations.length.to_i / 2
    selLoc = []
    stack width: 200 do
      para "Select directories"
      locations[0...locsHalf].map do |loc|
        flow { @upload_location = check; para loc, :size => 10}
        selLoc << [@upload_location, loc]
      end
    end
    stack width: 200 do
      para " "
      locations[locsHalf..locations.length].map do |loc|
        flow { @upload_location = check; para loc, :size => 10}
        selLoc << [@upload_location, loc]
      end
    end
    stack width: 200 do
      para "Upload Sub Directory"
      button("Select File to Upload") do
        @filename = ask_open_file
        @sel_fil_op.text = @filename
      end
      @sel_fil_op = para $filename;
      button("Upload Selected") do
        selected = selLoc.map { |upload_location, name| name if upload_location.checked? }.compact
        if selected && @filename
          servers.each do |server|
            selected.each do |sel_loc|
              lfile = @filename
              # cnt total uploads
              Thread.new do
                # access remote dir via FTP
                begin
                  # set per xfer vars
                  filesize = File.size(lfile)
                  transferred = 0
                  @p.fraction = 0.0
                  # connect and xfer
                  ftpCon = Net::FTP.new
                  ftpCon.passive = true
                  ftpCon.open_timeout = 2
                  # connect
                  ftpCon.connect(server)
                  ftpCon.login(user, password)
                  ftpCon.chdir("/Public/Shared Videos/" + sel_loc + "/")
                  # return upload status
                  ftpCon.putbinaryfile(lfile) { |data|
                    transferred += data.size
                    percent_finished = (((transferred).to_f/filesize.to_f)*100) / 100.0
                    animate do
                      @p.fraction = percent_finished
                    end
                  }
                  ftpCon.close
                  @status_op.text += server + " uploaded to " + sel_loc + " successfully" + "\n"
                rescue => e
                  @status_op.text += server + " upload to " + sel_loc + " failed " + e.message + "\n"
                ensure
                  # ftpCon.close
                end
              end
            end
          end
        else
          alert "Please select a file and directory to upload!"
        end
      end
    end
    # display upload ds
    stack width: 300 do
      border black
      para "Upload Progress"
      @p = progress width: 1.0
      @status_op = para ""
    end
  end
end
