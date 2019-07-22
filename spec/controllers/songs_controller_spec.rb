require 'rails_helper'

RSpec.describe SongsController do
  it 'downloads zip file from amazon through a redirect ' do
    song = create("song", id: 19, filename: 'act_cool_loveshadow.zip')
    get :get_zip, params: {id:19}
    expect(response).to redirect_to("https://cantandoinglesbucket.s3.amazonaws.com/simple/act_cool_loveshadow.zip")
  end
end
