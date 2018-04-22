package Hello;


import io.reactivex.Observable;
import io.reactivex.Observer;
import io.reactivex.disposables.Disposable;


public class ObserverHello {

    public static void main(String[] args) {

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
}
