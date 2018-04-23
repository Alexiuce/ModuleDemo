package Hello;


import io.reactivex.Observable;
import io.reactivex.ObservableEmitter;
import io.reactivex.ObservableOnSubscribe;
import io.reactivex.Observer;
import io.reactivex.disposables.Disposable;


public class ObserverHello {

    public static void main(String[] args) {

        example1();
    }

    private static void example(){
        Observable<String> ob = Observable.just("one","two","three");

        Observer<String> sub = new Observer<String>() {
            @Override
            public void onSubscribe(Disposable d) {

            }

            @Override
            public void onNext(String s) {

                System.out.println("====" + s);
            }

            @Override
            public void onError(Throwable e) {

            }

            @Override
            public void onComplete() {

            }
        };


        ob.subscribe(sub);
    }

    private static void example1(){
        Observable<String> obs = Observable.create(new ObservableOnSubscribe<String>() {
            @Override
            public void subscribe(ObservableEmitter<String> emitter) throws Exception {
                emitter.onNext("this is test");
            }
        });
        Observer<String> looker = new Observer<String>() {
            @Override
            public void onSubscribe(Disposable d) {

            }

            @Override
            public void onNext(String s) {

                System.out.println("next : " + s);
            }

            @Override
            public void onError(Throwable e) {

            }

            @Override
            public void onComplete() {

            }
        };

        obs.subscribe(looker);
    }
}
