class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    render 'posts/index'
  end

  # ここから
  def new
    # new.html.erbでは@postの変数を使用するので、インスタンスを生成しておきます。
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    # まず最初に、新しいPostオブジェクトを作成します。
    # その際にpost_paramsメソッドを通じて受け取ったパラメータ（タイトル、本文、画像など）を使って初期化します。
    # ここで、post_paramsはユーザーから送られてきたデータのうち、安全に使用できるデータをフィルタリングする役割を果たします。

    if params[:post][:image]
    # ユーザーが画像を送信してきた場合に対応します。
    # この条件分岐は、送信データ（params[:post][:image]）に画像が含まれているかどうかを確認します。
     
      @post.image.attach(params[:post][:image])
      # 画像が送信されてきた場合、その画像を@postオブジェクトにアタッチ（添付）します。
    end

    if @post.save
       # ここで、@postオブジェクトをデータベースに保存します。
      # 保存が成功すればtrueを返し、何らかの問題で保存できなければfalseを返します。
     
      redirect_to index_post_path, notice: '登録しました'
      #  保存が成功した場合、ユーザーを投稿一覧ページ（"/"）にリダイレクトさせます。
      # その際、「登録しました」という通知メッセージを表示します。
      
    else
      # 登録に失敗した場合に処理されます。
      
      render :new, status: :unprocessable_entity
      # 保存が失敗した場合、再度新規投稿フォーム（:newビュー）を表示します。
      # その際、HTTPステータスコードとして422（Unprocessable Entity）を返します。
      # これは、リクエストは理解されたが、バリデーションエラーや他の理由で処理できなかったことを意味します。
      
    end
  end

  private
  # post_paramsメソッドは、RailsのStrong Parametersと呼ばれる機能を用いたものです。
  # このメソッドは、ユーザーから送られてきたパラメータ（データ）から安全に使用可能なものだけを
  # 抽出・フィルタリングする役割を果たします。
  # Strong Parametersは、安全性のために重要な機能で、
  # 想定外のパラメータによる不正なデータ操作（マスアサインメント脆弱性）を防ぐ役割があります。
  def post_params
    
    params.require(:post).permit(:title, :body, :image)
    # params.require(:post)の説明
    # paramsは送られてきたパラメータ（データ）全体を保持するハッシュのようなオブジェクトです。
    # require(:post)は、その中から:postキーを持つデータを取り出します。
    # :postキーが存在しない場合、例外（エラー）が発生します。

    # permit(:title, :body, :image)の説明
    # permitメソッドは、:postキーの中からさらに指定したキー（この場合、:title、:body、:image）のみを抽出します。
    # これにより、これら以外のパラメータが送られてきてもそれらは無視され、データベースに影響を与えることはありません。
  end
  # ここまで
end
