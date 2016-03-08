require_relative "vars"

Shoes.app :title => "Studio Center Video Uploader" do
  stack {
    para "Upload Sub Directory"
    @upload_location = list_box :items => locations
    button("Select File to Upload") {
      @filename = ask_open_file
      #para File.read(filename)
      para @filename
    }
    button("Upload Selected") { alert("Good job.") }
  }
end
