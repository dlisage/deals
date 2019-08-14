require 'rails_helper'

RSpec.describe DealsController, type: :controller do
  describe '#index' do
    context 'with invalid response from api' do
      before :each do
        allow(RestClient).to receive(:get).and_return('error': 'Unknown api key')
      end

      it 'throws error' do
        expect { get :index }.to raise_error
      end
    end

    context 'with valid response from api' do
      let(:api_response) do
        {
          'entries' =>
          [
            {
              'id' => 12,
              'value' => '238.3',
              'name' => 'test 1',
              'deal_stage' => {
                'id' => 88,
                'percent' => 80
              }
            },
            {
              'id' => 20,
              'value' => '300',
              'name' => 'test 2',
              'deal_stage' => {
                'id' => 88,
                'percent' => 20
              }
            }
          ]
        }
      end

      before :each do
        allow(RestClient).to receive(:get).and_return(api_response.to_json)
      end

      it 'renders correct data' do
        get :index
        expect(assigns(:chart_data).key?(:data)).to be_truthy
        expect(assigns(:chart_data)[:data].count).to eq(3)
        expect(assigns(:chart_data)[:data][1][0].include?('20%')).to be_truthy
        expect(assigns(:chart_data)[:data][2][0].include?('80%')).to be_truthy
        expect(response).to render_template(:index)
      end
    end
  end
end
