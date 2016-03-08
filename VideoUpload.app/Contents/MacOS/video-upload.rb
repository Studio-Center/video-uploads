Shoes.app :title => "Studio Center Video Uploader" do
  stack {
    para "Upload Location"
    list_box :items => ["Public/Shared", "Videos/Archive"]
    para "Upload Sub Directory"
    list_box :items => ["populate later"]
    button("Upload Selected") { alert("Good job.") }
  }
end
