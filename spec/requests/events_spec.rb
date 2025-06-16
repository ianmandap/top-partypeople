require 'rails_helper'

RSpec.describe "/events", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:event) { FactoryBot.create(:event, creator: user, title: "Created") }
  let!(:attending_event) { FactoryBot.create(:event, :attending_event, attendee: user) }
  let!(:random_event) { FactoryBot.create(:event, title: "Random") }
  let(:valid_params) { FactoryBot.attributes_for(:event) }
  let(:invalid_params) { FactoryBot.attributes_for(:event, end_date: 50.years.ago, title: "") }
  let(:new_params) { { title: "Updated title" } }

  before do
    login(user)
  end

  describe "GET /events" do
    it 'shows Public Events' do
      get events_url

      expect(response).to render_template(:index)
      expect(response.body).to include("Public Events")
    end
  end

  describe "GET /event/:id" do
    it 'shows Public Events' do
      get event_url(event)

      expect(response).to render_template(:show)
      expect(response.body).to include(CGI.escape_html(event.title))
    end
  end

  describe "GET /event/new" do
    it "renders a successful response" do
      get new_event_url

      expect(response).to render_template(:new)
      expect(response).to be_successful
    end
  end

  describe "POST /events" do
    context 'with valid params' do
      it "creates an Event and redirects to it" do
        expect {
          post events_url, params: { event: valid_params }
        }.to change(Event, :count).by(1)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(event_url(Event.last))
        follow_redirect!
        expect(response.body).to include("Event was successfully created")
      end
    end

    context 'with invalid params' do
      it "does not create an Event and re-renders the page" do
        expect {
          post events_url, params: { event: invalid_params }
        }.to change(Event, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
        expect(response.body).to include(CGI.escape_html("Title can't be blank"))
      end
    end
  end

  describe "GET /event/:id/edit" do
    context "when authenticated user is event creator" do
      it "renders a successful response" do
        get edit_event_url(event)

        expect(response).to render_template(:edit)
        expect(response).to be_successful
      end
    end

    context "when authenticated user is NOT event creator" do
      it "renders an unauthorized flash" do
        get edit_event_url(random_event)

        expect(response).to redirect_to(root_url)
        2.times { follow_redirect! }
        expect(response.body).to include(CGI.escape_html("You are not authorized"))
      end
    end
  end

  describe "PATCH /event/:id" do
    context "when authenticated user is event creator" do
      it "updates the requested event" do
        patch event_url(event), params: { event: new_params }
        event.reload

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(event_url(event))
        follow_redirect!
        expect(response.body).to include("Event was successfully updated")
      end
    end

    context "when authenticated user is NOT event creator" do
      it "renders an unauthorized flash" do
        patch event_url(random_event), params: { event: new_params }

        expect(response).to redirect_to(root_url)
        2.times { follow_redirect! }
        expect(response.body).to include(CGI.escape_html("You are not authorized"))
      end
    end
  end

  describe "DELETE /events/:id" do
    context "when authenticated user is event creator" do
      it "destroys the requested event" do
        expect {
          delete event_url(event)
        }.to change(Event, :count).by(-1)
      end
    end

    context "when authenticated user is NOT event creator" do
      it "renders an unauthorized flash" do
        expect {
          delete event_url(random_event)
        }.to change(Event, :count).by(0)

        expect(response).to redirect_to(root_url)
        2.times { follow_redirect! }
        expect(response.body).to include(CGI.escape_html("You are not authorized"))
      end
    end
  end
end
