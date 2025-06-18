require 'rails_helper'

RSpec.describe "Invites", type: :request do
  include_context 'logged in user with events'

  let(:valid_params) { FactoryBot.attributes_for(:invite) }
  # TODO: no attribute to invalidate
  let(:invalid_params) { FactoryBot.attributes_for(:event, status: "") }
  let(:new_params) { { status: :maybe } }
  let!(:another_invite) { FactoryBot.create(:invite, event: event) }

  describe "GET /invites" do
    context "when authenticated user is event creator" do
      it 'shows guest list' do
        get event_invites_url(event)

        expect(response).to render_template(:index)
        expect(response.body).to include("Guest List")
      end
    end

    context "when authenticated user is event attendee" do
      it 'shows guest list' do
        get event_invites_url(attending_event)

        expect(response).to render_template(:index)
        expect(response.body).to include("Guest List")
      end
    end

    context "when authenticated user is NOT an event attendee" do
      it 'renders an unauthorized flash' do
        get event_invites_url(random_event)

        expect(response).to redirect_to(root_url)
        2.times { follow_redirect! }
        expect(response.body).to include(CGI.escape_html("You are not authorized"))
      end
    end
  end

  describe "GET /invites/new" do
    context "when authenticated user has not been invited to event" do
      it "renders a successful response" do
        get new_event_invite_url(random_event)

        expect(response).to render_template(:new)
        expect(response).to be_successful
      end
    end

    context "when authenticated user is attendee of event" do
      it "redirects to edit url" do
        get new_event_invite_url(attending_event)

        expect(response).to redirect_to(edit_event_invite_url(attending_event, invite))
        follow_redirect!
        expect(response).to render_template(:edit)
        expect(response).to be_successful
      end
    end
  end

  describe "POST /invites" do
    context 'with valid params' do
      it "creates an Invite and redirects to event page" do
        expect {
          post event_invites_url(random_event), params: { invite: valid_params }
        }.to change(Invite, :count).by(1)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(event_url(random_event))
        follow_redirect!
        expect(response.body).to include("Invite was successfully created")
      end
    end

    context 'with invalid params' do
      xit "does not create an Invite and re-renders the page" do
        expect {
          post event_invites_url(random_event), params: { invite: invalid_params }
        }.to change(Invite, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
        expect(response.body).to include(CGI.escape_html("Status can't be blank"))
      end
    end
  end

  describe "GET /invites/:id/edit" do
    context 'when authenticated user is event creator' do
      it "renders a successful response" do
        get edit_event_invite_url(event, another_invite)

        expect(response).to render_template(:edit)
        expect(response).to be_successful
      end
    end

    context "when authenticated user is event attendee" do
      it "renders a successful response" do
        get edit_event_invite_url(attending_event, invite)

        expect(response).to render_template(:edit)
        expect(response).to be_successful
      end
    end

    context "when authenticated user is NOT event creator or attendee" do
      it "renders an unauthorized flash" do
        get edit_event_invite_url(random_event, random_invite)

        expect(response).to redirect_to(root_url)
        2.times { follow_redirect! }
        expect(response.body).to include(CGI.escape_html("You are not authorized"))
      end
    end
  end

  describe "PATCH /invites/:id" do
    context "when authenticated user is event creator" do
      it "updates the requested invite" do
        patch event_invite_url(event, another_invite), params: { invite: new_params }
        another_invite.reload

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(event_url(event))
        follow_redirect!
        expect(response.body).to include("Invite was successfully updated")
      end
    end

    context "when authenticated user is event attendee" do
      it "updates the requested invite" do
        patch event_invite_url(attending_event, invite), params: { invite: new_params }
        event.reload

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(event_url(attending_event))
        follow_redirect!
        expect(response.body).to include("Invite was successfully updated")
      end
    end

    context "when authenticated user is NOT event creator" do
      it "renders an unauthorized flash" do
        patch event_invite_url(random_event, random_invite), params: { invite: new_params }

        expect(response).to redirect_to(root_url)
        2.times { follow_redirect! }
        expect(response.body).to include(CGI.escape_html("You are not authorized"))
      end
    end
  end

  describe "DELETE /invites/:id" do
    context "when authenticated user is event creator" do
      it "destroys the requested event" do
        expect {
          delete event_invite_url(event, another_invite)
        }.to change(Invite, :count).by(-1)
      end
    end

    context "when authenticated user is event attendee" do
      it "destroys the requested event" do
        expect {
          delete event_invite_url(attending_event, invite)
        }.to change(Invite, :count).by(-1)
      end
    end

    context "when authenticated user is NOT event creator" do
      it "renders an unauthorized flash" do
        expect {
          delete event_invite_url(random_event, random_invite)
        }.to change(Invite, :count).by(0)

        expect(response).to redirect_to(root_url)
        2.times { follow_redirect! }
        expect(response.body).to include(CGI.escape_html("You are not authorized"))
      end
    end
  end
end
