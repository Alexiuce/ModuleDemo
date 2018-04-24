import io.reactivex.Observable;
import io.reactivex.ObservableEmitter;
import io.reactivex.ObservableOnSubscribe;
import io.reactivex.Observer;
import io.reactivex.disposables.Disposable;
import io.reactivex.functions.Function;
import io.reactivex.schedulers.Schedulers;
import jdk.nashorn.internal.codegen.CompilerConstants;

public class TestDemo {


    private static Observer<String> observer = new Observer<String>() {

        @Override
        public void onSubscribe(Disposable d) {
            System.out.println("on subscribe");
        }

        @Override
        public void onNext(String s) {

            System.out.println(s);
            System.out.println("Observer::" + Thread.currentThread().getName());

        }

        @Override
        public void onError(Throwable e) {

            System.out.println(e.getLocalizedMessage());
        }

        @Override
        public void onComplete() {
            System.out.println("complete");
        }
    };


    public static void main(String[] args) {

//        justExample();
//        fromExample();
//        createExample();

        schedulersExample();
    }


    private static void justExample() {

        Observable<String> obs = Observable.just("a");

        obs.subscribe(observer);

        Observable<Integer> obs1 = Observable.just(2, 3, 4, 5);
        Observer<Integer> sub1 = new Observer<Integer>() {
            @Override
            public void onSubscribe(Disposable d) {
                System.out.println("integer on subscribe");
            }

            @Override
            public void onNext(Integer integer) {
                System.out.println(integer);
            }

            @Override
            public void onError(Throwable e) {

            }

            @Override
            public void onComplete() {
                System.out.println("integer complete");
            }
        };
        obs1.subscribe(sub1);


    }

    private static void fromExample() {
        String[] words = {"hello", "world"};
        Observable<String> obs = Observable.fromArray(words);
        obs.subscribe(observer);
    }

    private static void createExample() {
        Observable<String> obs = Observable.create(new ObservableOnSubscribe<String>() {
            @Override
            public void subscribe(ObservableEmitter<String> emitter) throws Exception {
                emitter.onNext("this is created observable");
                emitter.onNext("apple");
                emitter.onComplete();
            }
        });
        obs.subscribe(observer);
    }

    private static void schedulersExample() {
        Observable<String> obs = Observable.create(new ObservableOnSubscribe<String>() {
            @Override
            public void subscribe(ObservableEmitter<String> emitter) throws Exception {

//                for (int i = 0; i < 10; i++) {

                    emitter.onNext( "emiter::" + Thread.currentThread().getName());
//                }
                emitter.onComplete();
            }
        });

        obs.subscribeOn(Schedulers.io()).map(new Function<String, String>() {
            @Override
            public String apply(String s) {
                return s + "good";
            }
        }).observeOn(Schedulers.newThread()).subscribe(observer);

    }

    private static void testExample() {
        System.out.println("test");

    }

    private static void mapExample() {
        System.out.println("test");

    }

    private static void filterExample() {
        System.out.println("test");

    }

    private static void flatmapExample() {
        System.out.println("test");

    }

    private static void subjectExample() {
        System.out.println("test");

    }

}
