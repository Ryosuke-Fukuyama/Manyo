require 'rails_helper'
RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: 'テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: 'テスト', content: '成功テスト')
        expect(task).to be_valid
      end
    end
  end

  describe 'scopeのテスト' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:second_task) { FactoryBot.create(:third_task) }
    xcontext 'scopeメソッドでタイトルのあいまい検索が' do
      example 'できる' do

      end
    end
    context 'scopeメソッドでステータス検索が' do
      example 'できる' do
        within find_field('ステータス') do
          all('option').each do |option|
            expect(option['selected']).to be_blank
          end
        end
      end
    end
    xcontext 'scopeメソッドで複合条件検索が' do
      example 'できる' do

      end
    end
  end
end
