require "net/ftp"

# available servers
servers = [
  "192.168.1.21",
  "192.168.2.21",
  "192.168.3.21",
  "192.198.7.21",
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

uploads = 0

Shoes.app(title: "Studio Center Video Uploader", width: 500, height: 240, resizable: false) do
  flow do
    stack width: 200 do
      para "Upload Sub Directory"
      @upload_location = list_box :items => locations
      button("Select File to Upload") do
        @filename = ask_open_file
        @sel_fil_op.text = @filename
      end
      @sel_fil_op = para $filename;
      button("Upload Selected") do
        if @upload_location.text && @filename
          servers.each do |server|
            # cnt total uploads
            uploads += 1
            lfile = @filename
            # access remote dir via FTP
            begin
              # set per xfer vars
              filesize = File.size(@filename)
              transferred = 0
              @p.fraction = 0.0
              # connect and xfer
              ftpCon = Net::FTP.new
              ftpCon.passive = true
              ftpCon.open_timeout = 2
              # connect
              ftpCon.connect(server)
              ftpCon.login(user, password)
              ftpCon.chdir("/Public/Shared Videos/" + @upload_location.text + "/")
              # return upload status
              ftpCon.putbinaryfile(lfile) { |data|
                transferred += data.size
                percent_finished = (((transferred).to_f/filesize.to_f)*100) / 100.0
                animate do
                  @p.fraction = percent_finished
                end
              }
              ftpCon.close
              @status_op.text += uploads.to_s + ". " + server + " uploaded successfully" + "\n"
            rescue => e
              @status_op.text += uploads.to_s + ". " + server + " upload failed " + e.message + "\n"
            ensure
              # ftpCon.close
            end
          end
        else
          alert "Please select a file to upload!"
        end
      end
    end
    # display upload ds
    stack width: 300 do
      border black
      @p = progress width: 1.0
      @status_op = para ""
    end
  end
end
